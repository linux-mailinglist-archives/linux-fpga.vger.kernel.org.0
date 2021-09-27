Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E974198EE
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Sep 2021 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhI0Qfl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Sep 2021 12:35:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:41783 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235494AbhI0Qfc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="285520801"
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="285520801"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 09:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="586833240"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2021 09:33:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 09:33:50 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 09:33:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 09:33:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 09:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTBHi/9eXixN2ZAl7/ZknLi9NicS413NPvAn62z2isG8FiMbKhsYujp+SSgP7vFz04PHBnU1zoP1fqE6kzNOEICInXuytfNxmsW9TYx8jUJJnCRq6S9qIx5hjmyuoUT05XDGpYMFQjqtopB6rjncvtKg6OFi7hJRglgeN54MKptJBKvb2MfbSI9s56Tu71EL6GBRl1QS+64Nw+qIHPRsYOCYLHvMmLRv3ZY/JP7HIblCaGnXEXoPR/VfDnhSSyImjgeZLOIez2DmJzEOUzM7g+db7DXB9SR7HSu4lgJWI2V3EvE+ithcgkUpPIFF6eIkPdjDLqZfeCJAyX7HaThG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vutiSFILd187S4I3DdUeYS/uvEXhWbK8y7w1KCmMgdY=;
 b=WJllby35cN4IOHs83AC6ze2L9aqou/Mk9MJHShS+le0J3hih9RMSW1+LJgmboWjRzVn195BtyxE2MAKZiMkqkpFujgTYuWcDWdTjwip/wSVph+8sR24SE1/BGAAoDTRfyFFZNu85CBh1vmT4de6Lq+OrS0hapmBgZMR1JsDZB+22AgReH4WFCjVeNuRZQ/yXu43LIybjy0XdMk13v7qUx62e0buwt8Ca9Vfwp/XRaTz9G9NwCEKp6Z1y/+c11VzF+3pt7tvJZgml7NqHC7PevGnOwAJNn5uVi3uz0U2AJW/D0DfoK3ScYUY9JvCKcQChCohG2bLfDGJm7Dj30jZMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vutiSFILd187S4I3DdUeYS/uvEXhWbK8y7w1KCmMgdY=;
 b=KSvYk7PZHm/cAX1Itvg7xCYjjgT+5fs8wMk3H8qJCunDiKDn8fn3cmYAL9IUOnnr/N01AceUk0ivmaHmsFLjGMvDQxljP4oDZ9tGf51xNlQ/wZTLo9wBwJddf3ICk9qhheEi/IrFPWCWYwllLC57lqnU8ZAKK13VjgrRkxYzs98=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB4875.namprd11.prod.outlook.com (2603:10b6:806:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 16:33:47 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 16:33:47 +0000
Subject: Re: [PATCH v16 2/5] fpga: image-load: enable image uploads
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210923001056.282790-1-russell.h.weight@intel.com>
 <20210923001056.282790-3-russell.h.weight@intel.com>
 <20210924081220.GB806603@yilunxu-OptiPlex-7050>
 <6e4a8236-c0c8-d688-d3bd-4ea9cb88fa5b@intel.com>
 <20210926011036.GB1339205@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <5214232f-5cf2-d897-3f76-b72f48b9d512@intel.com>
Date:   Mon, 27 Sep 2021 09:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210926011036.GB1339205@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:301:1::23) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR11CA0013.namprd11.prod.outlook.com (2603:10b6:301:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Mon, 27 Sep 2021 16:33:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97616497-0ec0-41c9-db75-08d981d49427
X-MS-TrafficTypeDiagnostic: SA2PR11MB4875:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB4875DB6E817CB9B9F95AF4D1C5A79@SA2PR11MB4875.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzR/Q6crKTs4OJGpaadkFi6Zsd8KIbqZbHMIyqHelzCO5xU4lBc+Wr41v9PAsC188APWQVRa41M0fYCBNbkizFil0YPk65Yp6mIkxN6s2GwN+WYpnsB4yU6uBGR79pYEaQ3fcgIhA9XU+l3EBjItQdpiPo3oMxfZCR9U2OQ7R8R0rawFc1jR334/6qtICh+0wK8mIH/JIMqeAzERirANrg5vJrqkyumXYGfI8T7XwMQeN64efJHO7Iu+3qvGQIPkjV66owSWEg5vKb5fbWTP7EqS8wDWwPHUQE0l0eE/EsUdSVj7+i7v1LHavADOcETB8R7NHQjfsl0nm0WXAzThBxAhhH/4N3xJuk53qJLekR5Oua+I6/D8n83Hbl6UY5v71yPwAAOWb1cAeu+iYPomuSHbbGlaUTn8DtTa+tdal0u1V4vBs4vjbG+Y+qYWVtt1IE+7yz8LyK6xjThcQ0VkG6Mb4Q5jmqKM+pyhYobTIpKb9943eq9u41oqqhgsCaXg5TVFTdsAvOmxqdUca3Po27JFzaMLH03/M+1l0Nc6Krsx74xj3/gDcxB/RugAc73h4QAnh5qhBiFT/ZAtNLx4x/PQXjaPq3N4A2z0L8CXob2Rff/MeGAglS6RmSVtmCtxjH4/tXXb/ljH7Os4euA1HZO6nwSWei5gxKau9b7nF/hq+yXiH3AIuS6i5OzbedniducMMRzgS7u9EJHQ/YCuCjHV0Qec0QAXskyuRMvEcf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(8936002)(6862004)(316002)(36756003)(956004)(2616005)(38100700002)(37006003)(86362001)(4326008)(16576012)(2906002)(508600001)(8676002)(83380400001)(6486002)(6636002)(66556008)(31696002)(26005)(53546011)(6666004)(66476007)(66946007)(186003)(5660300002)(4744005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emE3LzNiZEFoWituc3Q2eDZWYzhLRnVGMmViVGtsWVkxQW5wWjU2S1hQaDlK?=
 =?utf-8?B?bUFoQTR2czJvd05WbFd3UEpaRVY0VFVEb0Roeko1VGxXOVEvQUFsYU9IWmpF?=
 =?utf-8?B?U0xDMzMyRUNmTE5qdTJoTDM2MXZmTnl0dnRxZ1cxNzU3dzJKNnZKZ1QrbGcx?=
 =?utf-8?B?MFlmdENUc21iYVd3Q2dHR2hTRDgwcFk1UUtEdjJHUWtnN2JkUjhjZGhVUlhy?=
 =?utf-8?B?TjExZGtydFM0SlB1YVpNTVZ4Y2dCWVBjSXJaYlhrOWpxelVNeEtTbzF4RTh0?=
 =?utf-8?B?dGZ3RXBaT2xuV2FxTE9lSlY5bHNTLzFoK3UxdWNHdFJXNXYvUXROL3hoblZ4?=
 =?utf-8?B?ek1CTnhERW5NWWh1dmRMZmY4dmVvM1ZqRk1VUzFCY044dENNNTM2REk5a3Qr?=
 =?utf-8?B?L2FkUTE1NHVoVTVtZ0lIeVdzVDQxZnhkTll5SkJpdXQ4NHRlVE9EODdDVGJy?=
 =?utf-8?B?VWpudDcyU3p5bTY3Q0ZhMHBqNG9sMjhKSlFkR1hyakN6YXNhTmx1dHlXM25w?=
 =?utf-8?B?RHBXbEFmOGJyV0E2aHNnYlBjWHZmQUt4WUExWnBzam5KU0JyM2dCRGtXZWdO?=
 =?utf-8?B?ejlvZkh1c3BWZXYzUHZhYXZNZVQ3dDBFODRTM2hRTG41SGJCSTFaRzNXM2hi?=
 =?utf-8?B?dzJoK0ttUDZlSVBFVXpDTS9YUDQ5eFpuNEJsRTRxaDNjMXRIT0x6R1pPenZp?=
 =?utf-8?B?SWRpWlNaUjYrbWJNSWhmQ1dkRXFvTDkwOERRVDlyTmFQUkJwUktDRmVVSURt?=
 =?utf-8?B?M2RWeFMrRUNaSHNRYTRNdXJjbU45TVdWNTdXbjFtbWEvY0Rpc1YydVA3QjRK?=
 =?utf-8?B?YVRuRS93N01xeGErdllRK3dxSFZHaWZRTGxSb0VkYmZYTU5rS1RLbzNxbEVJ?=
 =?utf-8?B?d2d0SVdQakNYemViNHlvMU9vQWVvTk9RdFJxa0dZU0YrTnNsTjVsOXFNL1Ez?=
 =?utf-8?B?cy9Na3FXUXB5bHUrdkttMjB0V2JoVzltaEZkeU02SVVEdEdvZFhzZ0NEM25l?=
 =?utf-8?B?WUZsdnMrd2dNQzBRbFZwbEl2aUVUVFp5M1UzRVUyWUtrUlp0M1RxUjlsWTBk?=
 =?utf-8?B?citrVnRwelZWNXJiK2tyRm16R21EUTFkYjErUGZFaHNKRW1GTC91b0hjTGIv?=
 =?utf-8?B?L2ZPeXc2Y0p2RnlGeldDRitWdlJZYUs1V3FydlFnVUp5dGJhL09NWUpsR2NJ?=
 =?utf-8?B?VGhsdGROQldray9pRzFZQ21uak9RdHNGWWRmUUhYR1k1SS9TaU9QZkIwTHVK?=
 =?utf-8?B?MXZGTUI3YUp2VlVvOGRsb2RsRW9nd1g2dE9JaFdOTnBsTUczWVJpTGRXNUZw?=
 =?utf-8?B?V05ZU3hpRGtBek5PVHJKcnI3TzU4NXFjL2FsQjZyS0YvcnhzVUpjYVoxTHcr?=
 =?utf-8?B?R3hIRDR6WWkwTHl3TkRuQWp0M0xsak5KSldKZzBlS1pFYm1uaDJaWmFsNkpv?=
 =?utf-8?B?NGFyaDBlWE1QM21uWlhhS2lhb3krVlBIR3o1YlFmS1NuYUVYRFk4VVhPLzVU?=
 =?utf-8?B?YzdmSkVRSGFPSG1jYnd4Nkdla0tKeS9YTHFEYXhtZi9Rd2o1ZGJXM2lXMXJL?=
 =?utf-8?B?bi9WaDFGZjR0eHNKKzNBVHNjN2VmRHJldUZYbWk4bHJTR0VTYVlaL09aT0dr?=
 =?utf-8?B?Lzd4ZlZlWWdKZjkzS1J5cUtsaDE1cEpjY0plQjhVMjBPc0FTNUxrbDEyUjBx?=
 =?utf-8?B?NHBRQXNwMHduUllRNGNPU2tuUndJdFdxenVnM2hTVmNXSm5FNHlPbTF4K0lO?=
 =?utf-8?Q?xyabJtLdkXtRj+7OGGvMM0os0KckWVAgyfa8QNm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97616497-0ec0-41c9-db75-08d981d49427
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 16:33:47.7774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIXuoXjN2H8gcVzeuMqribx3WMYKZ6lkPFg6z5HYssUCDbcjMBXUB+MvqThurZl1ZXJEB8ons9P678qYqYddCKLCWoiB9gObRlJK0fefMzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4875
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/25/21 6:10 PM, Xu Yilun wrote:
>>>>  
>>>> +	cdev_init(&imgld->cdev, &fpga_image_load_fops);
>>>> +	imgld->cdev.owner = parent->driver->owner;
>>>> +	imgld->cdev.kobj.parent = &imgld->dev.kobj;
>>> Could be replaced by cdev_set_parent()
> Sorry I ended last mail before this comment, and you may not notice it.

Yes - I did miss that. Thanks!

- Russ
>
> Thanks,
> Yilun
>

