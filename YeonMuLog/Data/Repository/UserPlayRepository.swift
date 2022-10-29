//
//  UserPlayRepository.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/20.
//

import Foundation
import RealmSwift

enum SortOption: String {
    case date = "date"
    case userReview = "userReview"
    case title = "title"
}

fileprivate protocol UserPlayRepositoryType: AnyObject {
    func fetch() -> Results<UserPlayInfo>
    func fetchWith(sort: SortOption, option: Bool) -> Results<UserPlayInfo>
    func fetchFilter(_ query: String) -> Results<UserPlayInfo>
    func createPlay(_ item: UserPlayInfo)
    func updatePlay(_ item: UserPlayInfo)
    func deletePlay(_ item: UserPlayInfo)
    func updateReview(_ item: UserPlayInfo)
}

class UserPlayRepository {
    static let shared = UserPlayRepository()
    
    let localRealm = try! Realm()
    
    func fetch() -> Results<UserPlayInfo> {
        return localRealm.objects(UserPlayInfo.self).sorted(byKeyPath: "date", ascending: false) // 최신 순서
    }
    
    func fetchWith(sort: SortOption, option: Bool) -> Results<UserPlayInfo> {
        switch sort {
        case .date, .title :
            // 날짜, 또는 가나다 순
            return localRealm.objects(UserPlayInfo.self).sorted(byKeyPath: sort.rawValue, ascending: option)
        
        case .userReview :
            // 리뷰 있을 경우만
            let predicate = NSPredicate(format: "#userReview.@count > 0")
            return localRealm.objects(UserPlayInfo.self).filter(predicate)
            
        }
        
    }
    
    func fetchFilter(_ query: String) -> Results<UserPlayInfo> {
        let tasks = localRealm.objects(UserPlayInfo.self)
        let results = tasks.where {
            // 극 제목, 공연장소, 리뷰, 캐스팅으로 검색
            $0.title.contains(query, options: .caseInsensitive) ||
            $0.place.contains(query, options: .caseInsensitive) ||
            $0.userReview.text.contains(query, options: .caseInsensitive) ||
            $0.casts == query  // 캐스트 이름이 일치하면 검색가능 (일부로 할 경우 String 타입의 프로퍼티가 있는 오브젝트 클래스를 만들어야함)
        }
        
        return results
    }
    
    func createPlay(_ item: UserPlayInfo) {
        do {
            try localRealm.write  {
                localRealm.add(item)
            }
        } catch let error {
            print(error) //사용자에게 에러알림 해줄 수 있게 처리하기
        }
    }
    
    func updatePlay(_ item: UserPlayInfo) {
        do {
            try self.localRealm.write {
                localRealm.add(item, update: .modified)
                
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateReview(_ item: UserPlayInfo, review: UserReview) {
        
        do {
            try self.localRealm.write {
                item.userReview.append(review)
                localRealm.add(item, update: .modified)
                
            }
            
        } catch let error {
            print(error)
        }
    }
    
    func deletePlay(_ item: UserPlayInfo) {
        do {
            try localRealm.write {
                localRealm.delete(item.userReview)
                localRealm.delete(item)
            }
        } catch let error {
            print(error)
        }
    }
    
}
