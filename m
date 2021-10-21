Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8794356A7
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Oct 2021 02:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJUAIP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Oct 2021 20:08:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:32155 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhJUAIP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 20 Oct 2021 20:08:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="292373019"
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="292373019"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 17:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="631694941"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2021 17:05:58 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 17:05:58 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 17:05:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 17:05:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 17:05:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvjsdybBz6gogD0Vb3omyqrtCeAHeAJkTV9A1P4tDIR84S5eq4KDCEVTILWsiZM5Jt6gAJflWFiXkWzk2GX/aJqPVpoS6B3AiZwCkV0wovQ8naBaRhLbxe/iq9bJw2ac585Y4YYg+WgpNUtA9krohi6bMz6u+PjLLmZlMjs85Dnqe1nm8XmXlTmEdcDDUcGCiP7Zh1avNTZM/QUS4JqXNeaJu14fsQh831ZlwyR4qXUCjdCvX52MlZDa9V/yjk6+0mI3q7EcaHMW1QZwwResRBal1LMs7UorSprIFuRHpfk5wjPHx821HfjUS62fBktPJBvFrPpAgGjneGg2BmCQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzVl397V828ClIZAiqEzsAiJOFZo4avFiY5zipyVei8=;
 b=WMjIn008HYyo3eFGKnACAxIhkTvoi+1lvuaPC4CD1tAITHbEEwtNjDikSTfbCFC0cSreHFSL5otCATeFLWY0JxkfAyEYNLVyfEdP5z6kCV3XH+PE8QGA8DIR4wThUfUf6D3O/mCG5ym3249kT5GtRwGHJB/tI0pZKdwNrxYfQdcEp3opChpVyEIVgwgJ9gIf6yGTDMd2jSNa+CXs8W8Og5zubY4r1Fr3EQrRe/Z9clKueHIWN4skUSmH2fbXB2PCe3WRFVnH7boxwIfoZUZxlCIk0ouVP78961KVAQ70Jh1ixEhbtkBXsUlnUwZWhUJyOceUOZgH2dyiqR5sBeeO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzVl397V828ClIZAiqEzsAiJOFZo4avFiY5zipyVei8=;
 b=OuBiNgLrEp0lM5QSTAeH7ptXTB2F5EQx7BFkhlBew0ephLnElpx2eeSgTW36syV0/w3ponqmvO9kE2g3u4eAlDFMQy4ZlgWjFnr5yaKwvFngF1nKt5N8j0mxrJ7TgSMmooxVX7xHBVsOk9Unzb3/hgCgiJ0Yze5+EgybayihAK4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3358.namprd11.prod.outlook.com (2603:10b6:805:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 00:05:55 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 00:05:55 +0000
Subject: Re: [PATCH v1 0/2] fpga: dfl: Log and clear errors on driver init
To:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
References: <20211019231545.47118-1-russell.h.weight@intel.com>
 <DM6PR11MB3819F29DF7B20FDED6DC814685BE9@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <f64249d2-1d48-c191-bce8-5e9e4a5e4643@intel.com>
Date:   Wed, 20 Oct 2021 17:05:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <DM6PR11MB3819F29DF7B20FDED6DC814685BE9@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::30) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Thu, 21 Oct 2021 00:05:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaaf069d-872b-488b-52fc-08d994268d4a
X-MS-TrafficTypeDiagnostic: SN6PR11MB3358:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB3358C42B7B64C87D8768B6EAC5BF9@SN6PR11MB3358.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrXaur8EwQmMs3DoYmpUfqciFJPHY7R0xesKIoD92Rbrf7bfn463JHwt5m9NCZ5zXKYZ0pruktbsxvAwS/PiZtqOmhwvxYm+AFnEN6rm4XkqLddGhaoPZFXDzrGCD6y/Qgrm2ZabaVtyujjZYsW1DAPRraUNE+RhLqBetbBWNNAqf05PIHY1jI0PccZDh5ba+bt8o9Cf5lLydnRc2yFLE2EAb+IjfGV/ZfjxQ6qyhmRyp9y8P2V7iNl0k/2Kzc571g0qeBxU4d/mwZeSgV3pnGaa4wIQsD1Z68u9QeAP3npby28O7SClAh/48qfK/SoGZWZ6P4J3S73Cnl2avcKGQtuX7UUgyiLcx1bcrVd4f6DrWMPni15RU/22j5vN7Q4H6Hrx+CgBznv2a6okubB9ruiMIOj0EmkdifMJyXQDWp/MuPqfTbCl1TNSI4Q+MTUgu3M6IhqxIX5u4BjSdP8Qil3JbaaTg1faz3CbyoCvka3o4rOXl7RsFMd2XbHAp72YuH1ifr8ga4Rl7DCWXKyi3rvBQV6fSwbdzcSiDu90sn7t1zVuLnmZ307HMdI85dIPBFwQJeZbmlsm8lj0RZEJq/qVTgxbYbCskby5eNc4X6VhJAIWNknj+9WDZB/mOEA8O3BVH/BWoNFG3mnpmvsEmq7ZGbNCbbT3LsUmmDhWju/L/EpjHPzUZchUMgfzroPSf3BWH2F2kcwDz3yFQUO+EJAoZi05lFNM1491O3PnVfxIkFElekJOQkmYJY7xGscb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(4326008)(110136005)(8676002)(36756003)(508600001)(186003)(83380400001)(54906003)(5660300002)(8936002)(66476007)(66946007)(66556008)(31686004)(6486002)(2906002)(2616005)(86362001)(107886003)(316002)(16576012)(38100700002)(31696002)(53546011)(82960400001)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkUwamVJVW85QXJ2eVZxWnFubHRvbjY1ZW1oaWFwL2g3VWlHZzFja1pYemFF?=
 =?utf-8?B?WWJzSkt4QkVmcTB2UWtYQitteEhKQ2VrLzJmOFFHZnNoMkV0NHVGN01aSVJ3?=
 =?utf-8?B?NThqS3Y0YXIwaEdDOVlqeTJCREFYVjNFckpyUkwySkRmRklXSXM5bWZKYlRP?=
 =?utf-8?B?alpUN0RoVnJ5ckg3RVM2UThPaFhGaWpwUzFyVmQ3Mmd1VVNNUFd4NnAyT25H?=
 =?utf-8?B?cWhJUUhxZmE1aEpJU0tPK1VleTEvY2NaaE93TzgxaUdmaDcrejhmMHFMaVZU?=
 =?utf-8?B?ZGRMek45YXBUWkxLTU9VQzQyVGhtNUFrOE5sOUcvbU1qc0wwcEV4SGVuUEp3?=
 =?utf-8?B?R2R5Q09wSHU2eUpFckh2OEgyb1VMSENnSkpjY0h4dmpyK2xuV3FpbmFmTURD?=
 =?utf-8?B?UkdCSktxMGhhTWtmajB1VnZlTnREa2NOdFVUcFgweUt4ck9ERE5PTS84NDhW?=
 =?utf-8?B?VDFvR01lRnBsYURYMXBCY0R1c3R0L2ViR3NZN2pFR2RDT2VkRnBoUG54N2hp?=
 =?utf-8?B?dlhyMzNaUloyNDdPUjh6WG84NFFQQ1JKSzB6ekdjWEFJVUNTWWdxU0UwWWd2?=
 =?utf-8?B?TExsUXhMRnFWVGo0eXZidmUwOGJUZjBJZFJUZW4vVHBjNkpHMFB3QzVVYU5Z?=
 =?utf-8?B?Mzh3MXpmT3pKRktXVG9EV0R3T01Od00yaGxybHFvMjI4R3RjMGR3bmpSWFRK?=
 =?utf-8?B?VWZWWDU4Ym1pK1JCakRBakU3UUNQQ0RyTHM3cS9vT3NQNlhYUlFzckJqTWE1?=
 =?utf-8?B?eXU0SEx2cTBiaTBLUUFuZklTU0ljWjFUNGVmVExYZEdQWFlGdXRoTWNOeENT?=
 =?utf-8?B?SjhrSitUbXFNNC9qSHU4VVgxc29VT1hybVQxSHlSUWo5NU5ZSzU1cEp6WVcy?=
 =?utf-8?B?cnNKeG1JSksxM0RSU0JXOG44MkVBOUdjczNSQnVQM3YyRUtNdXRpWnh2NHgz?=
 =?utf-8?B?anp5c0NEbjZrK0oyb29ENFBBaWRPYnpray9VcVJteDg2bVliWXAwQVJSZXFW?=
 =?utf-8?B?VXVQYkE5SWVPVmNHd1RwSjcvTEtnWC9aQmRHb05yVXErbjZvTktwb1VIMy9U?=
 =?utf-8?B?QzhCUDg0bGoxVlI0TkZWemdjb0t2aEJUOURWYklOZ0hCVm5mR1UrbWQ2bzY2?=
 =?utf-8?B?Nkw2VlA1czdzUE9CZHE0MW5xUS9nWnVsYUhEZDExK2w2dG1QOUQ1ekZKSUt4?=
 =?utf-8?B?VVRZRnJGQ1F5bzlwMVQ2ZXVDMUtYKzExY0NBVXdHSGlFQVA3cmIrR1d0cEE5?=
 =?utf-8?B?YkRsVjdCa3pVK2tEWE4xeGlPTkxwV2JmbXcxdVZxT3MrZzg1OStEVkdaWDZG?=
 =?utf-8?B?QXh4VTNDMlZrbHNyb3NyZkdOR2ErSUZuQmlGenJlVVplMWd1cTloZlZERm5B?=
 =?utf-8?B?VnFjdVkyUHQvOENoYVdUcGRLK3dtY3d3ajhmQ1RMcHU5RjJEL2I0Q2JoYSt6?=
 =?utf-8?B?dkZWSlU3dDh0YU5ZTTZ5SG1kYmpGWkh0Y0paRmlVT2x1Uzl4QnlrOUJ3blRO?=
 =?utf-8?B?Rnc2ZFJzbzV5SmtyeldDV1RrNmw4Z0NEMlFBWlF6Q3FmNEEwV0FXSzJLa1lw?=
 =?utf-8?B?dlZtMlkvclluTnFpZGx2K0dBK1o5ODB3a1h1RXBlT3kxTzM4aVArWEJ6OEJz?=
 =?utf-8?B?dzZLU2M5WEJIV3REUEhMdHBGaGgwSFpyQWJ6c1k0cjhQdHdXMGFuZUV0UW1N?=
 =?utf-8?B?ejZxQlZHVUhiK090RUFseGswK1kzRWJlRGdHL0ZRbHNJbGNkMTc5dHUzWjNy?=
 =?utf-8?Q?M4fWdIBuqJ9NaZrwn87f+qv/kEU4u1B6s9h1S/z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaaf069d-872b-488b-52fc-08d994268d4a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 00:05:55.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: russell.h.weight@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3358
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/19/21 9:44 PM, Wu, Hao wrote:
>> Subject: [PATCH v1 0/2] fpga: dfl: Log and clear errors on driver init
>>
>> These patches address a request to log and clear any prexisting errors on
>> FPGA cards when the drivers load. Any existing errors will result in print
>> statements to the kernel error log before the errors are cleared. These
>> changes specifically affect the fme and port error registers.
> Could you please explain more about why we need this change? 
> As we have user interface to log and clear errors already, is it a better choice
> to let userspace log and clear them during AFU initialization?
In the new architecture we are offering more flexibility to customers
for adding functions. With these designs it becomes nearly impossible
to design the AFU interface handler to recover from errors and resume
operation afterwards. The proposed solution is to flag the source of
the error and then capture it in sticky registers so that they can be
read out from SW in the event of a crash/warm boot. To ensure that we
capture these errors, the proposal is to log them in the kernel log and
clear them at driver initialization.

- Russ

> Hao
>
>> Russ Weight (2):
>>   fpga: dfl: afu: Clear port errors in afu init
>>   fpga: dfl: fme: Clear fme global errors at driver init
>>
>>  drivers/fpga/dfl-afu-error.c |  26 ++++---
>>  drivers/fpga/dfl-fme-error.c | 128 +++++++++++++++++++++++------------
>>  2 files changed, 100 insertions(+), 54 deletions(-)
>>
>> --
>> 2.25.1

