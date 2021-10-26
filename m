Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250B143B8D1
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Oct 2021 19:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhJZSBX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Oct 2021 14:01:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:39533 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238004AbhJZSBW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Oct 2021 14:01:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="230247741"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="230247741"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 10:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="722561358"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 26 Oct 2021 10:41:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 26 Oct 2021 10:41:20 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 26 Oct 2021 10:41:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 26 Oct 2021 10:41:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 26 Oct 2021 10:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdBiP11ZAUGdk4EdufoN5pLi+sLg5kuCR8banzvgfj1ZOewZy2Aa8aRsnkEUmv2Hv8gRBV6MMZDzZrtj6d0ZQAMPKbkPvrH3m7Hs1/aY1O71njAPdJT6ZgudqaTn/FcrvkdvJVW3JwMU2RYb+wKEhXKZivgSjLiX2W696jV3SlGe26jBqjhBdASoW0N3llDVgILlKmjGJZq1c+AFL1gBFcWG9mWmYCw31tjSHMsO4C+I3ujIsgwymXUlEAteQfdlVFZr6J1gT1/qmFu4rESLMvnUZd66BgBh8lPZgNKJQbHKP6ZV8JJN/16pySjrZ31f9czqYcz1g9iinAxijeA+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5enQZkudc38qO1Y1vjgFHV2zF3NPBLa59+Xur3ZArTY=;
 b=EVW0Djc+4bIumNs53fL298YXiMGdwVmklSqv2kowIAbDkTspRvlTp0+yAfcWMiXU0dFynOOUx4aLoVEL6TEYSul1jG+MvaHuLN/Vyq6409mPFHzRvsnbBHH67JGEWo+ore+xfYsLKT0JpBGZXMPUNfFz4GnyGjzX5/dKskkctAlRQ29PK4zI07uGppOISWsctiiB4+/jGLuMVBmxRFs9CGwLJGVcBREe3Q8gGBMCJc+vZqDC2CG1S4dzlAy3bJmhf1VtNdkSyJ7vPYmIpmoCZiYyP94mD4L0/BPZUmG0KG2St6WCo1fScEMtJnNe0YbgzJ42VrvVqet0bzzRM6wsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5enQZkudc38qO1Y1vjgFHV2zF3NPBLa59+Xur3ZArTY=;
 b=XKLoIWGaVCz/n2V/z/7XO84EX/nKuekjYqiMIEyztMICCHEnXGd6HgT6QW1gLBwR7PuhlzhU/NxLo8HbmK11VJjMg1VnnuGgqD7aVAxa0usKxibtviLymRa1U/TvCbd0yFFggPvAdKl961WnDpicwfu/6tW7Fz1sU9/8VnC7vTU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3406.namprd11.prod.outlook.com (2603:10b6:805:bb::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 17:41:17 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%8]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 17:41:17 +0000
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
References: <20211013010617.GE95330@yilunxu-OptiPlex-7050>
 <58036b2d-ca8f-2deb-f1b4-0301d633714b@intel.com>
 <20211014014947.GF95330@yilunxu-OptiPlex-7050>
 <7d1971d0-b50b-077f-2a82-83d822cd2ad7@intel.com>
 <20211015025140.GH95330@yilunxu-OptiPlex-7050>
 <2b26bea5-60d3-6763-00e8-9a94fa0bf45b@intel.com>
 <20211018081356.GB40070@yilunxu-OptiPlex-7050>
 <301850cf-9f34-530b-bd9c-fbe9bf9feee5@intel.com>
 <20211019025356.GC40070@yilunxu-OptiPlex-7050>
 <85d56e4b-5bed-693d-4f76-027173a6e7a0@intel.com>
 <20211020011608.GA145760@yilunxu-OptiPlex-7050>
 <38cfb530-8826-7890-da59-c1dd33b9cc7d@intel.com>
 <DM6PR11MB38198F9B969569FDDD71A1CC85849@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <03ff4983-d8a9-6ad7-a655-a8dcde3da360@intel.com>
Date:   Tue, 26 Oct 2021 10:41:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <DM6PR11MB38198F9B969569FDDD71A1CC85849@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW3PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:303:2a::23) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW3PR06CA0018.namprd06.prod.outlook.com (2603:10b6:303:2a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 17:41:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96cf3d22-64db-4d5d-32d2-08d998a7d037
X-MS-TrafficTypeDiagnostic: SN6PR11MB3406:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB3406D162F7FB7CF0E2DDCAD7C5849@SN6PR11MB3406.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeDQ9NVhp/3lmF9qrsw/1tmBGMKsvNlOoHjowRby5bngg62RKJOtjjH3NGNpvBN0fuuTvMn1Cd5xTwcuE2vup3AcDOsPkKpKRP4LINvjmphGVLlm7CZk+Fo2NRsTehuRyjLh6TfvCMVL3CakLux7XmZAAyhs63V2PVzv8Trf6Z0V8VGRlDR6Dc2npwstUmOspWCyTJGtf2VdvNAHDhJRj0A2Dqq2nbEOq4XlCdtom+339tI0IskZFUfIF7B7WUy6nYMahFw+U1GSxDqhHyBq93U6di1t8dmMixcqWLy5MztvWlvgdu4hBL6Z57e0qBvJjg4hk1iAyI/hdcWoQuUip2aPlrTj58XT82C/OpRpoYb28V/VYPNwkt7l8aStFjf9nBr+v64DPIS0UAMF6CG98b/2ENSoSnpZoBcv+c5hlGwYcga+9diuMQTRMHMqkkJkkt8uiM4Rt0gp+PUnVX1tS9BMhsDTYAc+8V6YcJBiO0VfsYQy1vxH8PxlZaQ28S4LZvORA7y5neZa5rZf2fN6ripIUN2bwGHuNilXXpqR7081aDJFLblzwhOoQqPPF4JVAoI+n/iREBrMPqp1AoUcTeaj2Z8vI6tTNkixqB2izL1CClDOEvXTKMjM5bLAtQbm4mhXUyvlntfY50AguskCVYwDyCMX8NWkSK15D7dd8MCNcGB3ragJ7AMzLzVbu1gYHmyfwm1JcvluqF2dp2y9nw69cnoxDi9WD6QL3ORAjO9A7fgHEsgwY8QXwpgTCr6j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(956004)(31696002)(36756003)(83380400001)(8936002)(316002)(4326008)(66946007)(15650500001)(2906002)(38100700002)(82960400001)(110136005)(31686004)(26005)(8676002)(54906003)(6666004)(5660300002)(16576012)(186003)(66556008)(53546011)(66476007)(6486002)(107886003)(508600001)(6636002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0c5R3B0ZDJKRkJYemkzL1o2SVRFNndpUnh4VnlyenJtbXVZb2hadGVkRHhJ?=
 =?utf-8?B?WHR1T3gvU3dyVDdVRERrVmJCVkdQcmZHTmVpd1Y5bzJTdklrMnMzNUh1ZWZ5?=
 =?utf-8?B?NnkwL21EU0xDVkpIZHVYVEwvUXd3djNOSGo1QzF0NTFDM09YYnNCSnlJM205?=
 =?utf-8?B?UmJMZWJjOHk3SVZldEh2b2U0SldsZTlmZGZ4QmJOZVkrbVpubnk4emZWUlFF?=
 =?utf-8?B?ampqZWFscjVPc1ZGeW40NHhZeFdFT1VBZlRFcDdKS3RkU3F1cnM4aFgwdlhQ?=
 =?utf-8?B?bFJQS2JEdGZpZlVpc1VXWTFtaWVQN2pVNkxNYVpmL3dLN05OSzhEVGc1MEIz?=
 =?utf-8?B?S3N1R3pZWHY4emJJdllhZ3JmeXVKVEVid3EyRkk5bFJVR2Z1cWY5SHV2K2kr?=
 =?utf-8?B?ZlkvN3pvMXRzeHdaN2VhbjdwVElaQ2NxTEhMbDNONUhsZlppZytDbUlIOTBR?=
 =?utf-8?B?SU1vRWl1VXBvMm9Ec2l2SGZuK1lHTnF4RU5ndHNQRHVEV09RSW5HNkozem5U?=
 =?utf-8?B?ZDV1ZlVIVStTenRzdTRuRDJsL2FhTVpNaFlPL2FLUXB3bnVETlRhU1V3YUx2?=
 =?utf-8?B?c2VGMXBDSlloTUE2d0NGTGtxTS9hWmNkclZQdldtRHhUK0lSQ05pMjhXTDhP?=
 =?utf-8?B?S01HK2x4R3NqTGhQZmttRkI1VC9hYWQvQURvSW9MbzFYaWlkcHNmRDdOMzgx?=
 =?utf-8?B?cThyU290bVlGbkdGcCtNSVFuN010eFhjZkcrZnNTQTlNOHU3YXE5Ynp6V0tS?=
 =?utf-8?B?NHlzZ09QbzZWbW5RYUxvWm94VnA2Lzhsa0RIbDh5eGgwRU1DeUp5cFJHRU5C?=
 =?utf-8?B?WFNEUFd3ZGtac1d1OTRiSHZOdEpSTWhuV2RwNXRNR0R4UHlxVnRXYUZsd0JL?=
 =?utf-8?B?a3pjaW5tWjhPdXEvTDNzUmU2YWY3RmZIdW5VU2t2VlcxelB5VWdKUG8vYXZt?=
 =?utf-8?B?V3BENGxYNkcvWWNEZ1k4VnlaUHJ1a240a1pWUzZheUNRRVRJT0hwcmdTeEhG?=
 =?utf-8?B?SzlsWVhHVEhIQlZNNnN1RElkTjAydlJEWTFvclJuRVZDZUZlRW04RTcrUGk2?=
 =?utf-8?B?bnJ6UlJSZWJ2eDNISDY5eFdZQkM5N3BnNGtyNFpPS2xaRGQ1T3luWnhZcGtY?=
 =?utf-8?B?Sm45VXR2cGtMZ1pGLzNFYjhXR3ArM0JyOFduQktEYTEycng5SVQwNnhBQWFT?=
 =?utf-8?B?NU1KQmdDblQxT1hCMm9YL2h6bmVvOHhydFpQQVQyQXlYb3lwcFBzRmhRSXVy?=
 =?utf-8?B?U2kzdXV5MUZWS2pNcElTZTRSYzREaUhXeGNXRlpNZE9sakx3bnJ0dXcxQ0l1?=
 =?utf-8?B?cUZsVDFMbEhjRzZrbDUyUmp6aGNOejBaWkRBZllmVWRmWG9ISERyd2MzV2NE?=
 =?utf-8?B?Z09qZjBCZ01kUUdSaDIvYk1HTEJYclJFRHBpYlA2QytQb0RCcmpYR1dOY0Qw?=
 =?utf-8?B?QXB1ZEQzZmZNY3JESEg0TDl1Ry85dDFxcnlxYTliYmFOR09hcDAvODhVQmNt?=
 =?utf-8?B?NHpYN1lTZFpSRlZNMlJPeFFUMGxlTGdlcklYSDNJeXUvWWliZjIyNCtSKzE5?=
 =?utf-8?B?b0gvUm5WZzZqTWxQWEZQdDdvSm1PTWNXTFMwS2NLRlFGL05GOExDcU1XcUps?=
 =?utf-8?B?eEQreVc3M2JLa3M1WG1aeklKTVg1emJmZ3JHL0FUOTl5Vk9rM0srdERxclJh?=
 =?utf-8?B?clRkNmpmVmw3M25objdKMTgrRXQyNDJ1VWttSmw3alVoeDk5TFBqNm1ZbWtv?=
 =?utf-8?B?czFMYVZOcEs1UFVQVHFnbXhIQTBNTTNpSTVNZEVoN2JFSVVvYVB1ZUUwaVFF?=
 =?utf-8?B?cXErMEFZTlFYTmYyRDNCbjlpeW1vekgyM1Zlc2xjMmMxYS9uNVVoMk9CN2J4?=
 =?utf-8?B?U09DTDVDdTBRSzVwNHlRUTZ6OXZOenZtVHhLSlFwK0xVSHM3ZHQrM0J5Skww?=
 =?utf-8?B?NGpGVE5SeGpaRjRhVHVvejI0N3hYWTRTRWlrY2NoWkdVVWVtOHpwSkFzbjlm?=
 =?utf-8?B?ZklxYm5UWm9BWUl4NG81YmpwTm5pNlpRSUx4cndzV0JUSzRKcVcyQ01vdXFs?=
 =?utf-8?B?Rkk4ekREejFHbmcxZ1UrM2ozWVl1RjhWVTNMeFRBS2dnTEtpejFDWHZBUFc3?=
 =?utf-8?B?ZmpKUGRsaEYxVXhQaEpSa1pPRjFJN05EbFZPN3l4dXF2Nk5WazM4Njd3YkRu?=
 =?utf-8?B?b29kOU55UllkVEpkSnJvenJGaHRDeGpnaHdvSzFzeU91UmhVNzNBQ1hnckFO?=
 =?utf-8?B?K2VWTmtSR1ZGOFBGRzY5MlpZVXhBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cf3d22-64db-4d5d-32d2-08d998a7d037
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:41:17.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNCmOM9GBoTKNXsaLFvYI5y5aHKJL9cZxamPmnxAYrohdWjzyxAzcosHXku5QeM8SKkuR8WudbElNl3QTTBqrvdEMuJCBLEnBWreAgslkwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3406
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/25/21 11:45 PM, Wu, Hao wrote:
>>>>>>>> The FPGA Image Load Framework was designed with the concept of
>>>>>>>> transferring data to a device without imposing a purpose on the data.
>>>>>>>> The expectation is that the lower-level driver or the device will
>>>>>>>> validate the data. Is there something fundamentally wrong with that
>>>>>>> I think there is something wrong here. As I said before, persistent
>>>>>>> storage updating has different software process from some runtime
>>>>>>> updating, so the class driver should be aware of what the HW engine
>>>>>>> is doing.
>>>>>> So far, there are no self-describing images that cause a
>>>>>> change in run-time behavior, and I don't think that will
>>>>>> happen for the very reason that the class-driver would
>>>>>> need to know about it.
>>>>> Again, the class driver needs to know what is happening, at some
>>>>> abstraction level, to ensure the system is aligned with the HW state.
>>>>>
>>>>> If the class driver cannot tell the detail, it has to assume the
>>>>> whole FPGA region will be changed, and removal & re-enumeration is
>>>>> needed.
>>>> So we make it a requirement that the self-describing files
>>>> cannot make changes that require the class driver to manage
>>>> state.
>>> The API should not only define what it won't do, but also define what
>>> it will do. But the "image load" just specifies the top half of the
>>> process. So I don't think this API would be accepted.
>> So what is the path forward. It seems like you are saying
>> that the self-describing files do not fit in the fpga-mgr.
>> Can we reconsider the FPGA Image Load Framework, which does
>> not make any assumptions about the contents of the image
>> files?
> Why we need such "generic data transfer" interface in FPGA
> framework? 
Are you referring to the use of self-describing files?
or the generic nature of this class driver?
> we need to handle the common need for FPGA
> devices only, not all devices, like programming FPGA images.
> So far we even don't know, what's the hardware response on
> these self-describing files, how we define it as a common need
> interface in the framework?
The class driver does not _need_ to reside in the FPGA
framework. I sent an inquiry to the maintainer of the
Firmware update subsystem (and cc'd the kernel mailing list)
and received no responses. I placed it under the FPGA
framework only because the first user of the class driver
is an FPGA driver.

> If you just want to reuse the
> fpga-mgr/framework code for your own purpose, Yes, it seems
> saving some code for you, but finally it loses flexibility, as it's
> not possible to extend common framework for your own
> purpose in the future.
If I understand correctly, you are saying that it doesn't
fit well in the FPGA manager, because not all file types
fit the definition of a firmware update? And future file
types may not fit in fpga-mgr context?

- Russ
>  
> Thanks
> Hao

