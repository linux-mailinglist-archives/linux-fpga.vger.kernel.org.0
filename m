Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB2443CD2F
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Oct 2021 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbhJ0POT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Oct 2021 11:14:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:6576 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236709AbhJ0POS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 27 Oct 2021 11:14:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="230455525"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="230455525"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="537615444"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2021 08:11:52 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 08:11:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 08:11:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 27 Oct 2021 08:11:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 27 Oct 2021 08:11:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEXWdtTBKVRYXYKps6zLFIKDgtlyAQLBVFyajOAinFbMEc27ZaHbZIPD6OX5/GQROzFyRBK6wKlZ1vucbPj01yKU6VAW7ExKDWkN4FmVktmcp8QtwqhGaT6ye0quEMQLKZPc6P2PVB3FF8xuueeqoH4zo5dhkgkjXKxVKUSDSEf+pT6uizjsUBWzOWNECbdvKrDeYNAvuL2DNRypB72CjZni7VkD1gF3SbpXw9O38chezdYYLat1pebkU4QtP4Q77wvVvKA+o2wB/PlGtNQajKmWT7SKAnPppULtndzLFma5jaLD1iARedRt6qMT1ERVYEY6Efo4hgzGnb33YAombQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3Hecj/M832opaR6L37nr0brjSCVUMCuTd8eugaQLvc=;
 b=cMClQH2yI9StNvw0uRiRVde8XkJVhTaPUX3tsWF2xMBH0Ubm/DZmW84AW+As+/sIGOyKkWRSKfFNPpxCYEkSe3Kl6klli2PzEUuOJo/k4yBk2ngxkGpDm9vN9WcOKIeHq8df+JQSgPPG3hnpCV2ubi2oA8AHGiabRUwxfDghwnLAMUye6jt0XnDZ2Vzg592Va0nVtAGo5YEZWm6ynmQl0VA8guHKmVbrqsT7myeMbZRnDwmQT9IvSrKap8vsvdFCw6UqiPzCt7tu/1EszFXaDuSNZ6ukWHNncM1n6QHCh9h+Yv86q7uUv/K/EchvKt21B8RSSXm1rHcyDmv57r6y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3Hecj/M832opaR6L37nr0brjSCVUMCuTd8eugaQLvc=;
 b=IcWV5NcmX1G+APaugvMpEJ6zBZ/N9F+VsdVPFt/hO5b99rzTD9EZLURSskKVUqlSIW4crf6iVmmLLyhZ+MDQwf6PQBMVA/8VIVE5GN1L59YkOANzLbiiSdiQTUt2+KLFXoNeZ77X7usxPGzfIU7bUlopB7ZY373q9wQeDlYt6Wk=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3501.namprd11.prod.outlook.com (2603:10b6:805:d4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Wed, 27 Oct
 2021 15:11:48 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%8]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 15:11:47 +0000
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
 <03ff4983-d8a9-6ad7-a655-a8dcde3da360@intel.com>
 <DM6PR11MB38192DC4A39D654F88322D0C85859@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <e5fa668d-d32c-2285-1145-b1e9128508ec@intel.com>
Date:   Wed, 27 Oct 2021 08:11:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <DM6PR11MB38192DC4A39D654F88322D0C85859@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Wed, 27 Oct 2021 15:11:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b883af3-e451-4dde-3b57-08d9995c1851
X-MS-TrafficTypeDiagnostic: SN6PR11MB3501:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB350143FA7B76DE812E1C6652C5859@SN6PR11MB3501.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aj2SQ/lTnhl4uFKniza48/sPi+U1V2hBVTx+AG+M8qHrM2sWW81yAk4J3TsPOzIVBlF7F6X6IlSlYeVafTHYjKBW567onTPNGshdW2pkEgSPEn8tFsRXwIhMTKrsxH6uPhulHJEkA6tzlYQUa53ytG1MXn6ij5Cm6pnBa3zUdzJ3rau3FsNCuirOPEKj0hugkhR2OaYJW2RqiTjkFBTdN8q1Y5Pf1jdFzZ6yx1KAw848aLAtHJpL4l9b8kY2mD+9ARTqJiqcrYj85nVMbLQ2l5nBjx2RTBtbCxAqOIvop1wsqnHLm2AFOy1vXzmLL55i7Sc3sEhXCgYrE/fPrhkzTsMueFUxoed585bnE8AfxO3NVTOpPxR7J71wxkX5MLwHO7L794056EyslVSzNM6zZzVlx8vtr6Lvq7xg0dHAx60HGRAvtGRbPUyyK98IkCY2RI2HO3Bt7VDpQRO8HZuwMGl+7uh1DVEHa+lpAv/4rcUPdhMYAJaNo7jNyJNPfuSSFM1BZftBYYvSKW9kgjU7UsnyNLXiqe1oJ2VWIqxKNgCTsOrTpBIe2uCCHrTrtZ/f7VpengrxI56u+Mizo3mqhPqXZbjsdwnKV7alfh88Dr35VpUjhzkKIa0O5u+7qckUqCKefmNetggCOz6smhNZGH00EuswzyeRYjJqgcJIKc+3WeDHnsfUE/lcSlucRX3uoq/mjgV+Zk4uy9niOb7cx3s0acPTG1NYIqEzuEGjJGiwcH8PmbtvSGeUaqQ/ePgA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(53546011)(186003)(86362001)(6486002)(38100700002)(316002)(36756003)(6636002)(956004)(2616005)(66946007)(66476007)(5660300002)(54906003)(110136005)(16576012)(508600001)(31696002)(107886003)(8936002)(4326008)(66556008)(31686004)(83380400001)(15650500001)(6666004)(2906002)(82960400001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9XZW5zcHpBOVlyNDJIQUt5NzNzSzdyc3I1Ukp3VzJzL1JIMWhqanREeUh0?=
 =?utf-8?B?SU00NkZqREhNL2YwSHZyR0NmRDR3b2ZUM3NnU0kxNVpMeWRBMFk3UmxadGhm?=
 =?utf-8?B?OGlyVFR5Y1VTRWt1VU9EK3FZT0VTeXRHbFlEVkFyd2xpRnhyOTJETWhocEhm?=
 =?utf-8?B?KytzOEZiNEdoSVAyVVczbUxOK1FUWjl2dEFmR2QyV1B5OGhGSFVEOUN1SHpI?=
 =?utf-8?B?TllGSnN6cHE3TkkyY2pFZ0R1d0UwSmh2Y1o3NlgxVm5hbzFRUHVYWCtzMGxj?=
 =?utf-8?B?WkhsTitobHdJTXhpL0RFM1ZZQTE3UG8rLzF5OFdPRXc5T1ZyM2dENnpCazlW?=
 =?utf-8?B?azFrVlhMTUNVQ2NuOWZqaXRrV3kwWHRhZ0dCMFV6eEhxT2RiR3dnUjhQZUFi?=
 =?utf-8?B?akExcDB2bnJZUzErM0NEeDRyL09rb28xU1pJU0JiMFUrem15L254YUt6UWFi?=
 =?utf-8?B?V0lkKytrN29yMmd2VXY4WlZOaVhlazJQeFpsbUxkOWJjRVYyNXc0OHRVckd6?=
 =?utf-8?B?dm5LSGgrSkV6cFRrTVJqSFkvcnprMkVxRXNSelF6WUU2NUdkNGZDSUdueTNw?=
 =?utf-8?B?MWhHU040azA3ZSsxeE8zdnNOZDZYcG1JZlZoZzlyQnV0a29nWGo1WTR5QnFh?=
 =?utf-8?B?aFlHODdBK1JqMlBmbjBlOWpad0EyZzlwMzVzYWtsMHJEcmhFQkZWdHBVUlpv?=
 =?utf-8?B?OWxJSENRazA0RDlQZWpTQmxQU2hjOHFRWEZPeUJydlpSN3VzZzBDMFNQTGx4?=
 =?utf-8?B?ZDRTSTNKSnVOc2VYSXRrL1R0dXBuQlR0ZE42TVE4M1F4eDFtOXRPbUM4QXRv?=
 =?utf-8?B?V3VKNWMrcTFlYzRmalNqUzdnQ1NRK0xjM1pJU3pTSXFsc0xWSDB3Mm9RNGhh?=
 =?utf-8?B?b0lWZG1OZWFDR2ZLcXNKRUt5aGhSa1R2bDJUOGYvWjZ2YzNuYWM0dG1jb1BK?=
 =?utf-8?B?Z0ZJaWYzZzBmNll2YXNJcVNhOCtEajdFQVlqOElQT1ZGcXRkZGJFaUhXdkVz?=
 =?utf-8?B?bnBYUEJNQjZRcHlvVFBpWlhlM0Y0cXFLV1IrWFIrS3A5a1BBU25BVkE5SXVx?=
 =?utf-8?B?ejd4YXZiTUNzczRYRXQyNkF6VkVySmJHT0h4ZkJDOThjb0c3dmdVbkpxMDJq?=
 =?utf-8?B?TEpaS2hzT1V4NjdXeGlxSjFVNnN0S3NJYzhwd1lVNDVnSm1Kb0xBOG9waEUw?=
 =?utf-8?B?UFMxSnNXaVF0TU9kYjVSKytjVmVaZktMd01NK0o5MS95TWQ4cmQrcFg4RkYv?=
 =?utf-8?B?T0tBWmdkRzg2SUlZWlJiWXNDOTloL0syV24xWE1YL1RJUHIveityNDdMMnhE?=
 =?utf-8?B?Nm5aN2ZjSjB6bEY4NDR4c1I1TC9Hd3JZdzZNeDF4NjltbDliNlBLdXppQVdp?=
 =?utf-8?B?N3ZVTWtTOEFxb0ZIVk5LQTBWeFB1T3I4SlgrMkFmMzYvSG10OGJ4ME5UMnVM?=
 =?utf-8?B?K0VrMjBqbnVZL2Z5eXcwbk4rNi9aZld1aG16aVhMbHpySkRNR0JGRmtCQlVX?=
 =?utf-8?B?SEMyK1ludm9XbFpDa1VzOFFsUDF6aURTNlRGcDV4S2Q2UFhJYUQ2STZmcGhL?=
 =?utf-8?B?S2FkNTFRc09qKzR5U2ZNRzdHdXIvQ2JvZ0VlRGtWVkIzVm83WGZCV01aQ3BK?=
 =?utf-8?B?bUtva0QxUEFpOXJCUG9FMytPUENYNW4wc0N2SVZjbEdMU0NIT2UvYlB5V0gw?=
 =?utf-8?B?UnBDSHczUkczSTZpMVNkdWdJYWFMU2xUSHlDM0ZxdE9yWGN2dHJGVVpldGNM?=
 =?utf-8?B?VkpFOFBVcEQzQjJqV0p4em8rVjlVdmNxR0ROazJ1bFFiOWNhdUUyR3NzVVBB?=
 =?utf-8?B?cW1WL3duYVlwYzZpend2aEZmNTFlLzNHaVAzSWlHNGtFUFZzZlFZU3plZUNs?=
 =?utf-8?B?NTNWS2ZleGNjQTM3UXVBOGhBL2RQaHhFMXBVN09wZ3UxQ3JrT1ZJdXVEZEpo?=
 =?utf-8?B?azRrWFBsQ2VpcmU2ZHl2UGxFZGphb1RYWUdzUk1PZHVXa3I0c1pFRjgzaWVH?=
 =?utf-8?B?dHZkZUFUaWsrMm9sTzZad2pYV08xWDg2R2F4ZzhPN0lKU2YyUFJrWVlzZ0ZC?=
 =?utf-8?B?emxDdUdST1ZjamxCTkplUUl2OXVkOHd1Z0dqZU9JTmdnRjBTQkpHYzdkTVc0?=
 =?utf-8?B?UExuY2M5ZndFaXFYdlpWUUlHSzZHbDI0VnJTMkMreHZ3dFZvaXNQOHNmMWoz?=
 =?utf-8?B?VlJhTHVpa2Yzb251OW9qVmlId0djUnNISGxSTHJWUXBrNzV3QjBsc21aUC9Y?=
 =?utf-8?B?NFhJeXJ2WS9JbDREcUltc1pieDBRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b883af3-e451-4dde-3b57-08d9995c1851
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 15:11:47.4798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNER8sj9YzhsZQvYDYTq7svFj6BohkZab1VI0auWWJIddJbd/FSGaIZzQ938pTo/uHXyb7OxqXxMv84altswCc4KxyHgWFsxiOAl/11Yv2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3501
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/26/21 8:29 PM, Wu, Hao wrote:
>>>>> The API should not only define what it won't do, but also define what
>>>>> it will do. But the "image load" just specifies the top half of the
>>>>> process. So I don't think this API would be accepted.
>>>> So what is the path forward. It seems like you are saying
>>>> that the self-describing files do not fit in the fpga-mgr.
>>>> Can we reconsider the FPGA Image Load Framework, which does
>>>> not make any assumptions about the contents of the image
>>>> files?
>>> Why we need such "generic data transfer" interface in FPGA
>>> framework?
>> Are you referring to the use of self-describing files?
>> or the generic nature of this class driver?
> Yes, why this is under FPGA framework? Per your description that
> it can be used to transfer any data, e.g. BMC images, some device
> specific data (self-describing image?). Let's take this as example,
> if FPGA device is replaced with ASIC on N3000, do you still want
> to use FPGA image load framework to transfer your device specific
> data, e.g. BMC images? I really hope that FPGA framework code only
> focus on common usage of FPGA. 
>
>>> we need to handle the common need for FPGA
>>> devices only, not all devices, like programming FPGA images.
>>> So far we even don't know, what's the hardware response on
>>> these self-describing files, how we define it as a common need
>>> interface in the framework?
>> The class driver does not _need_ to reside in the FPGA
>> framework. I sent an inquiry to the maintainer of the
>> Firmware update subsystem (and cc'd the kernel mailing list)
>> and received no responses. I placed it under the FPGA
>> framework only because the first user of the class driver
>> is an FPGA driver.
> You must have enough justifications why this needs to be included
> for everybody not for our own case.

How do we justify it when there are currently no other known
users? I can go ahead and work up some patches for the firmware
subsystem, if we can resolve the other concerns below.

>>> If you just want to reuse the
>>> fpga-mgr/framework code for your own purpose, Yes, it seems
>>> saving some code for you, but finally it loses flexibility, as it's
>>> not possible to extend common framework for your own
>>> purpose in the future.
>> If I understand correctly, you are saying that it doesn't
>> fit well in the FPGA manager, because not all file types
>> fit the definition of a firmware update? And future file
>> types may not fit in fpga-mgr context?
> Let's split the use cases, I think the use case that update a persistent
> storage for FPGA image, and later use hardware logic (FPGA loader)
> to load it into FPGA. This sounds like a common usage for FPGA
> devices, so I think this is why Yilun propose to have this part to be
> covered by fpga-mgr. But for other cases in your description, e.g.
> BMC images, device specific data, self-describing image and etc,
> they are out of scope of FPGA.

Self-describing files are not something new to us; _ALL_ of the image
files that we send to our FPGA cards, including the N3000 FPGA and BMC
images, root-entry hashes, key cancellations, etc. are self-describing
files. They always have been.


>
> Actually I don't fully understand why we need to introduce the
> "self-describing image" as a common data transfer interface, if
> I remember correctly, for N3000, different sub drivers will own
> different hardware sub function blocks, why expose such a new
> shared communication channel?

There is no change here. The N3000 files are self describing. The
secure-update sub-driver of the MAX10 BMC invokes the class driver,
funnels image data to the BMC, performs handshakes with the BMC,
and ultimately returns status through the class driver. All images
that are sent to the FPGA card follow this same path - and it works
fine.

To try to split out the purposes of each self-describing file to
use different kernel APIs means interfacing multiple class drivers
to the same MAX10 sub-driver. I think it also means replicating
code.

- Russ
> If "self-describing image" is a
> request to one of the sub function block, why not just expose
> new interface in such hardware block per modularization? I
> have some concern that this new requirement may break
> current driver architecture for N3000.
>
> Hao
>
>> - Russ
>>> Thanks
>>> Hao

