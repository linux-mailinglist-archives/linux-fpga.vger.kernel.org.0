Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404AC529277
	for <lists+linux-fpga@lfdr.de>; Mon, 16 May 2022 23:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347138AbiEPVG5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 May 2022 17:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349150AbiEPVGn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 16 May 2022 17:06:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3729825C50;
        Mon, 16 May 2022 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652733906; x=1684269906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3GYxPRgIc4LY1ARPSEiqHCXcJP50ralYJrbvFi/SrUg=;
  b=OGOqdHSZ18e832awgP4pQjFq9C3WeqLe4qluqQCw702mM4qWE5xRtLu9
   eUY/Zp7ASgKxLNOlaxO4uFkzRvlaaPeyhesuI/2m0X+XbUxnjDwxxyh7B
   UrdDP4H4+xsyS4p1MwDP+LX5R8zJ1FcT8oXqY3inxWldpVFxSnQh+yK4z
   VU53iCwEsBmDUK46rBlibmiwi4B10pxJNkIC9p6hXr64rUJkQOCscMPb6
   52Nsjweq3m09ZDsMvg5lXSr81JLbm1r8EmrLtHHbatv4qtawP093CvmWp
   qgXTbHkHMzaaQ5yATeW2ve1501TZeJi0QvOI85yDiHLicoGz9bls1J7vR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="296231035"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="296231035"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 13:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="713537293"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2022 13:45:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 16 May 2022 13:45:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 16 May 2022 13:45:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 16 May 2022 13:45:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 16 May 2022 13:45:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwBcgIzPFKmGSbu6f3OofcJe+T4ClECljtq9sTJX1LvESrhSxRNkJ/JkH7Vlt6lXNXZXV0zQG3AKe5khtk56u+TvH/v+BuZljwtBTHyvuEaFg9FUA+lsZ+VmrM/GIoAQhAkKRODfwtBqshriCRXUZ1M836rOQ1jZZHqctQNVoobXbhnx8lPVajSpx5hcXz4WCQqtLIz0bYacTSoySd24rAzAx8RJZRrrbEedOTcKLkkcaeSUdriogGIWUqn8qncJHmqPxgMIEOCLDe8wgopcxOSKj4lR/Ja6pbvcjHkRMfeWUaMYW6d0r0dZ5FwAbxJNFwBaMup/2DsAobiLwgGGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFj9IFkwbr8gbkry2Lt1ildB1OrekPfZRfZCBO6JAag=;
 b=CZ81vfBfAejCMO2mDryzrM0YAMDySDnpnM9AfqgOzqMowMV0tX82evvd3zztzhDN101uriU/E5icY5ydD0gCQJNys9zvuH+zz3ruE2DCDlM8y3lLQRnJFxC3j3GDFExfBp7Hhw7qclpeq9EYmToF86nwa1fPM7zEAdDQcg76Upq1ke/oWEWWbPwAD/nkQeLeB1f1QXXeHqL3iwSaQNwJuM2xYUN5SeH1O0XncOigayA+FajtO0StlsYBDsqVgoFAzBhdFdO7sY7BioD0KOUeEjrGhxTJpi05XiQYYPYJOdUuIlFOegxhoQtjWyXMs95JIcJ7dRb4zYU0+m4dMSr26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DS0PR11MB6327.namprd11.prod.outlook.com (2603:10b6:8:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 20:45:03 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 20:45:03 +0000
Message-ID: <48459308-2ca8-78ff-d81d-c119cc10e1a5@intel.com>
Date:   Mon, 16 May 2022 13:44:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v19 2/5] fpga: m10bmc-sec: create max10 bmc secure update
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <lee.jones@linaro.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <marpagan@redhat.com>, <lgoncalv@redhat.com>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220510195635.140722-1-russell.h.weight@intel.com>
 <20220510195635.140722-3-russell.h.weight@intel.com>
 <20220516161907.GA37553@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220516161907.GA37553@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:303:b7::12) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69f86ff0-9d55-4ebd-9524-08da377cf391
X-MS-TrafficTypeDiagnostic: DS0PR11MB6327:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DS0PR11MB6327360162EEAA5DADE31CD7C5CF9@DS0PR11MB6327.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+/ah7WRCiFSM9bOzVB8/8m+zzBYEE8Q+Yepcjp3mx3dbDPjEAas9NijUvoGZnw5kk1U3JoZgEqHVNu3tJR3SiqaydNJu3NABipXjPkYfOkBaEcLzgOCUu46n1i3t35lVL4mnYoIktsp3DKu8mBispFwQzdfDQXxcc1zvI9XtRuT2kRKK1/N0iSF2quGOnmbvc3W8gGKSnmOQCz3Ga9eSubDRwP/weeK3G1YPwYtqrx/BOt9J/RMRa52ZRA8q5mW65UxAUbLPGE8NewEHlX3KFADtTOsTe8RG8fPRiCxI9Gqzkw3J8u+MbD8oVv1KsU80V0xdk3A+kuZUWZoZIxQk0LLBiI1RAt4FIG+T2kDJS2Wk0tFJj6fHMxl9G8p+74ZrTG/cXC61gDxjR/7+DahwF7HYBH33aFFE9zxFmmF9+hdEK/kQdqQKiXCTpsOKT3rC8iRJbYSFNonHFF3GRzZgrISfUFsBt8FqCKt1ytNmJnf6G/2Q1PtkNGYzzDBREVG7AYGPfQgj9HaQfm07fs3O2orw+ywLON3VPUGirHBjZoieCokatf/Uky6dhTq7guQ94NdOOVSe8Muqf6JzShDEbM5TiD/77cCLR4cQqTFV2U9Mt70lutiwdsEIkWqMOGFl1EA+Y+FfFdGQbbLasKBKBXg1VXz7N36sLgCK5bbQ55JnQJpn9DlVQY6Wh+glkV+yjXXlASANvJbrcjynbxiWDLlGY/4vhDNgN+H79MRBiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6636002)(316002)(2906002)(508600001)(15650500001)(31686004)(31696002)(186003)(86362001)(83380400001)(8676002)(6666004)(36756003)(8936002)(5660300002)(53546011)(38100700002)(66556008)(66476007)(6506007)(6512007)(26005)(66946007)(2616005)(82960400001)(37006003)(30864003)(6862004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVtZ2s1eHIxTUJOeVkrdmthRkhxSkJEWVBDQVB1ekxRZGIveElucXpRWDRv?=
 =?utf-8?B?bnpoMXVoZ1pIb2R3RzQ5ZTZiT1kydUhGNUorNFM4eHJYTXNDelM4d1JUTW1E?=
 =?utf-8?B?dEpvVU5LaGpES0VnRlhDK2xVQjd2WVk3eVdpeEs1VHdnYWxTNkJaYWo1UHFz?=
 =?utf-8?B?VEtia0RCVUdTR1JNaWx1Q0NlcUZ6RmF3NlpOV0xxNGFWYlZmMkRlWkk3blFq?=
 =?utf-8?B?QmY5N3ZkS2pTM2daamV6a1hIV21halBmTFMzZlQyN3ZRTVUvN1EybFNrU3RZ?=
 =?utf-8?B?aGplTFY3ZllTNHZ1M3IvZDg5enRhMFdpVzk1aUpYVWswemlpN1kyVEZRVDkz?=
 =?utf-8?B?a0Z1ZEZJNGI4RWh1UlBYekFzMHJEVGl4Y1EvV2t3aTRkVjZZSEdMVkhNQWFw?=
 =?utf-8?B?MDRhd095UXRBMzdXbWNXMlVvVHdwS0J6V1gydndacllvaWRNZFNuU0NaYVNG?=
 =?utf-8?B?SFArT2lMSTQ4Y29vSGlwRkg3a3FNbU96blRjVDBVYjF2M2FicVgrZnI3bktK?=
 =?utf-8?B?NVJFOHNabEZ1M21paUtXY2JndWdQMllXU2NKYVNPYnd5MUFaQjVvcjlTZDBT?=
 =?utf-8?B?eW9pdnYxS2xGK0owaklaNStpR0FHc05zQmdxTlBidjhpOUQ2ZnFvWk5LeGQ1?=
 =?utf-8?B?aE5VMlJjR3phby9aYit3Kys2djBBWlI1VTBLSU04OVlLN3NCMkhwY0ttOE93?=
 =?utf-8?B?MVI0WFkrSDFzN0IvdE1vNi9tckJRRkY5Y3M3Qi9ub0s4cGhVWXU5SWFhMXYv?=
 =?utf-8?B?UWJvSW9nRElJTVM0bXhFWEVmSlhudzhrSEhSdzhLTEFiaUxsMFpkMytqTnVr?=
 =?utf-8?B?dmVkZmFuRUZCSFkxYzZNc3NzNnFOV2cyV3o1T05OMFc0UkhmbWpsczh0S3hS?=
 =?utf-8?B?ZHVpOE83cUlJSWdlcnAyREpnMjVDelJGZ05HOG9QTzh2aGU1c0crWDRJZWQx?=
 =?utf-8?B?ZHlBejhDWk1PZzdobXVDVHlLVm41UnA5OFlpbDg3SHJDc0NuOVlEcVpoZ1A0?=
 =?utf-8?B?TGtjYzJreW5jWnpEYVNNODN5dVpsdWhsV2ZOVjJqVi9vMFhGeldFT2lsMVN6?=
 =?utf-8?B?dFI2dXBtdjFiVUpSTE9pTmhLcXQ4UjlsRTZ4RmtndGtxeTlvSDdjZHl1V29P?=
 =?utf-8?B?Z0ViL25ORmg4a3hOa1JaN1pydFV3NmlaeXlWS0w3Q0lkTlg5bnprQ1BodW9Y?=
 =?utf-8?B?T0hTRTlXeGlTQVBTUnZIeDU5bWV1V20vOXZnS0NJeWtzYTlOZTNLWVdlQUhi?=
 =?utf-8?B?Y2d2aU41MmVQWTU5UEJFUWN6QVc2ZGRDYndrYVBCRDdNYlA1UGtaWVJUb3hp?=
 =?utf-8?B?V1VxdjBxNmJEckZXV3JDbGtDNjJtVlBBZEhJUDgwN1Z4MjlaQ2ErQ3JGNm00?=
 =?utf-8?B?Mzl3LzNoK1hOZW4xRmpaejF6Yk44elJrK2ZlN3FOeGpqNGk3U0h2RW1jNXFL?=
 =?utf-8?B?eStiRnBxclRPTnMxbDB5dzcxNkRZMnMyNXZkNHZ2SzVZSFV3L3ZsTHd3eDEy?=
 =?utf-8?B?cksxdVE0RW9BRDBTUlhSWGNKTXoxckxvUm5BS1Y4NnlSWUtXNHUrVkhFOTZQ?=
 =?utf-8?B?bnh3bVF2KzNTbU42RElYUzhITWc0ekplMUVKOFFzUUNuL1FtOVRub1JRSGls?=
 =?utf-8?B?d3BrbE4wck9xNzQwUVkrQmNsVHkyMmdScUZHcmI5aU9iTGs4K0t0a0ZrZW1z?=
 =?utf-8?B?MTNuYzNNQ0c4RGVKN1JBWFVOOTVSbkNMU1dvOWZTZTV6TzhHS0FRSWthaEpl?=
 =?utf-8?B?NkJqa2RoRkx2SXJsc2YvZjgvTmtGaGcyYTljZVd1ZTJhU3VTbThuK2pVREov?=
 =?utf-8?B?VW9RVlpsaUYxSlFjd0ptdnF5L0pHTG9idVVPOFdOaVNsdE9pQkNERjVyM2Na?=
 =?utf-8?B?amxpS0hLbW5UWXUxeXg3aWxIT0RlZW5mUDMzbU9XbmlBaUJBclpVWDQwUUNl?=
 =?utf-8?B?VjBHVWNzZU8zUlpTMDIvTWpwRGxlOHMxWlBSSHF6ZVhycmMwRWVuWnh3dG45?=
 =?utf-8?B?YmpiQXphTFRQTEYzd0JXejVia0M1eEI1elp5OExJNG52OHFvS3BmNldsUGlm?=
 =?utf-8?B?Sk55cHRYVDd4Mlc2c3plK2xyd2FFK2ZLbjRoRk91c2lHZmtVRXgzL0tqd1A3?=
 =?utf-8?B?UmpQVmwrajVQWTlDblJLNEQvTy9aMEZEdEljZFYrVHhTazNyelpDMlNXaW5L?=
 =?utf-8?B?TjBvY2dZbFhVc3ZTUGVnTHpPb25XQmNSNmtuVHZIZ3JiZWZPUkExeE1CZzJV?=
 =?utf-8?B?dFdZTnNGT0ZOL05ia3p4b24yOUM4Vk9wR1JETkVoMjFaWUtaanR3Z21JZVBt?=
 =?utf-8?B?cGVnMWxyZWwwYlVFUHRRSWhMOFZxblk1NG9laTA5UEp3allVNEFCNzZHalU5?=
 =?utf-8?Q?+G38oTVj9DM3tHCg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f86ff0-9d55-4ebd-9524-08da377cf391
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 20:45:03.0254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWYKnrJ4VkL6rsolneZBUug7imL0Luq2LbruC8WKXYTJfvPGIaS0zBxLEV//Hn6TnLjVrOEt9k4fSTmF82CPFs7UucqgBI5o9790Bx+L8yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6327
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/16/22 09:19, Xu Yilun wrote:
> On Tue, May 10, 2022 at 12:56:32PM -0700, Russ Weight wrote:
>> Create a sub driver for the FPGA Card BMC in order to support secure
>> updates.  This patch creates the Max10 BMC Secure Update driver
>> and provides sysfs files for displaying the current root entry hashes
>> for the FPGA static region, the FPGA PR region, and the card BMC.
> Could you describe a little more about what is the root entry, and how
> the root entry hashes (maybe also the cancel code signing key) work to
> ensure secure update?
Yes - I'll add some more descriptive text.

>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>> ---
>> v19:
>>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>>     with the parent driver.
>> v18:
>>   - Changed the ABI documentation for the Root Entry Hashes to specify
>>     string as the format for the output.
>>   - Updated comments, strings and config options to more consistently
>>     refer to the driver as the Intel FPGA Card BMC Secure Update driver.
>>   - Removed an instance of dev_dbg().
>>   - Deferred the call to firmware_upload_register() to a later patch
>>     where the required ops are provided. The bmc_sec_remove() function is
>>     also removed from this patch and added in a later patch.
>>   - Switched from MODULE_ALIAS() to MODULE_DEVICE_TABLE() in anticipation
>>     of additional cards to be supported by the same driver.
>> v17:
>>   - Update the Date and KernelVersion for the ABI documentation to Jul 2022
>>     and 5.19 respectively.
>>   - Updated the copyright end-date to 2022 for the secure update driver.
>>   - Change m10bmc to cardbmc to reflect the fact that the future devices
>>     will not necessarily use the MAX10. This affects filenames, configs, and
>>     symbol names.
>>   - Removed references to the FPGA Image Load class driver and replaced
>>     them with the new firmware-upload service from the firmware loader.
>>   - Firmware upload requires a unique name for the firmware device. Use
>>     xarray_alloc to generate a unique number to append to the name.
>>   - Changed the license from GPL to GPLv2 per commit bf7fbeeae6db: 'module:
>>     Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity'
>> v16:
>>   - No Change
>> v15:
>>   - Updated the Dates and KernelVersions in the ABI documentation
>>   - Change driver name from "n3000bmc-secure" to "n3000bmc-sec-update".
>>   - Change CONFIG_FPGA_M10_BMC_SECURE to CONFIG_FPGA_M10_BMC_SEC_UPDATE.
>>   - Change instances of *bmc-secure to *bmc-sec-update in file name
>>     and symbol names.
>>   - Change instances of *m10bmc_secure* to *m10bmc-sec_update* in symbol
>>     names.
>>   - Change instances of *lops* to *ops* in symbol names.
>> v14:
>>   - Changed symbol and text references to reflect the renaming of the
>>     Security Manager Class driver to FPGA Image Load.
>> v13:
>>   - Updated copyright to 2021
>>   - Updated ABI documentation date and kernel version
>>   - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
>>     functions instead of devm_fpga_sec_mgr_create() and
>>     devm_fpga_sec_mgr_register().
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>> v11:
>>   - Added Reviewed-by tag
>> v10:
>>   - Changed the path expressions in the sysfs documentation to
>>     replace the n3000 reference with something more generic to
>>     accomodate other devices that use the same driver.
>> v9:
>>   - Rebased to 5.12-rc2 next
>>   - Updated Date and KernelVersion in ABI documentation
>> v8:
>>   - Previously patch 2/6, otherwise no change
>> v7:
>>   - Updated Date and KernelVersion in ABI documentation
>> v6:
>>   - Added WARN_ON() call for (sha_num_bytes / stride) to assert
>>     that the proper count is passed to regmap_bulk_read().
>> v5:
>>   - No change
>> v4:
>>   - Moved sysfs files for displaying the root entry hashes (REH)
>>     from the FPGA Security Manager class driver to here. The
>>     m10bmc_reh() and m10bmc_reh_size() functions are removed and
>>     the functionality from these functions is moved into a
>>     show_root_entry_hash() function for displaying the REHs.
>>   - Added ABI documentation for the new sysfs entries:
>>     sysfs-driver-intel-m10-bmc-secure
>>   - Updated the MAINTAINERS file to add the new ABI documentation
>>     file: sysfs-driver-intel-m10-bmc-secure
>>   - Removed unnecessary ret variable from m10bmc_secure_probe()
>>   - Incorporated new devm_fpga_sec_mgr_register() function into
>>     m10bmc_secure_probe() and removed the m10bmc_secure_remove()
>>     function.
>> v3:
>>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>>     Update driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>>   - Changed "_root_entry_hash" to "_reh", with a comment explaining
>>     what reh is.
>> v2:
>>   - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
>>   - Switched to GENMASK(31, 16) for a couple of mask definitions.
>>   - Moved MAX10 BMC address and function definitions to a separate
>>     patch.
>>   - Replaced small function-creation macros with explicit function
>>     declarations.
>>   - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
>>   - Adapted to changes in the Intel FPGA Security Manager by splitting
>>     the single call to ifpga_sec_mgr_register() into two function
>>     calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
>> ---
>>  .../sysfs-driver-intel-m10-bmc-sec-update     |  29 ++++
>>  MAINTAINERS                                   |   7 +
>>  drivers/fpga/Kconfig                          |  12 ++
>>  drivers/fpga/Makefile                         |   3 +
>>  drivers/fpga/intel-m10-bmc-sec-update.c       | 133 ++++++++++++++++++
>>  5 files changed, 184 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>>  create mode 100644 drivers/fpga/intel-m10-bmc-sec-update.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> new file mode 100644
>> index 000000000000..2bb271695e14
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> @@ -0,0 +1,29 @@
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_root_entry_hash
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the static
>> +		region if one is programmed, else it returns the
>> +		string: "hash not programmed".  This file is only
>> +		visible if the underlying device supports it.
>> +		Format: string.
>> +
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_root_entry_hash
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the partial
>> +		reconfiguration region if one is programmed, else it
>> +		returns the string: "hash not programmed".  This file
>> +		is only visible if the underlying device supports it.
>> +		Format: string.
>> +
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_root_entry_hash
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the BMC image
>> +		if one is programmed, else it returns the string:
>> +		"hash not programmed".  This file is only visible if the
>> +		underlying device supports it.
>> +		Format: string.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cf883b1ec852..759a7788dad9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7784,6 +7784,13 @@ F:	Documentation/fpga/
>>  F:	drivers/fpga/
>>  F:	include/linux/fpga/
>>  
>> +INTEL MAX10 BMC SECURE UPDATES
>> +M:	Russ Weight <russell.h.weight@intel.com>
>> +L:	linux-fpga@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> +F:	drivers/fpga/intel-m10-bmc-sec-update.c
>> +
>>  FPU EMULATOR
>>  M:	Bill Metzenthen <billm@melbpc.org.au>
>>  S:	Maintained
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 991b3f361ec9..0831eecc9a09 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -243,4 +243,16 @@ config FPGA_MGR_VERSAL_FPGA
>>  	  configure the programmable logic(PL).
>>  
>>  	  To compile this as a module, choose M here.
>> +
>> +config FPGA_M10_BMC_SEC_UPDATE
>> +	tristate "Intel MAX10 BMC Secure Update driver"
>> +	depends on MFD_INTEL_M10_BMC && FW_UPLOAD
>> +	help
>> +	  Secure update support for the Intel MAX10 board management
>> +	  controller.
>> +
>> +	  This is a subdriver of the Intel MAX10 board management controller
>> +	  (BMC) and provides support for secure updates for the BMC image,
>> +	  the FPGA image, the Root Entry Hashes, etc.
>> +
>>  endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 5935b3d0abd5..139ac1b573d3 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -22,6 +22,9 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
>>  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
>>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
>>  
>> +# FPGA Secure Update Drivers
>> +obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
>> +
>>  # FPGA Bridge Drivers
>>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
>> new file mode 100644
>> index 000000000000..a36856d897c9
>> --- /dev/null
>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Intel MAX10 Board Management Controller Secure Update Driver
>> + *
>> + * Copyright (C) 2019-2022 Intel Corporation. All rights reserved.
>> + *
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/device.h>
>> +#include <linux/firmware.h>
>> +#include <linux/mfd/intel-m10-bmc.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +struct m10bmc_sec {
>> +	struct device *dev;
>> +	struct intel_m10bmc *m10bmc;
>> +};
>> +
>> +/* Root Entry Hash (REH) support */
>> +#define REH_SHA256_SIZE		32
>> +#define REH_SHA384_SIZE		48
>> +#define REH_MAGIC		GENMASK(15, 0)
>> +#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
>> +
>> +static ssize_t
>> +show_root_entry_hash(struct device *dev, u32 exp_magic,
>> +		     u32 prog_addr, u32 reh_addr, char *buf)
>> +{
>> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> reverse xmax tree declarations is recommended. You may initiate the
> variable after declaration.
Yes - I'll make the change.
>
>> +	int sha_num_bytes, i, ret, cnt = 0;
>> +	u8 hash[REH_SHA384_SIZE];
>> +	u32 magic;
>> +
>> +	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
>> +		return sysfs_emit(buf, "hash not programmed\n");
>> +
>> +	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
>> +	if (sha_num_bytes != REH_SHA256_SIZE &&
>> +	    sha_num_bytes != REH_SHA384_SIZE)   {
>> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
>> +			sha_num_bytes);
>> +		return -EINVAL;
>> +	}
>> +
>> +	WARN_ON(sha_num_bytes % stride);
> The user will still get the output value which is broken. So why not
> check the condition earlier, and stop user from accessing the interface
> if it cannot work.

Sure - I'll move the check into the if-conditional above and return
-EINVAL if it is true.

>
>> +	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
>> +			       hash, sha_num_bytes / stride);
>> +	if (ret) {
>> +		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
>> +			reh_addr, sha_num_bytes / stride, ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < sha_num_bytes; i++)
>> +		cnt += sprintf(buf + cnt, "%02x", hash[i]);
>> +	cnt += sprintf(buf + cnt, "\n");
>> +
>> +	return cnt;
>> +}
>> +
>> +#define DEVICE_ATTR_SEC_REH_RO(_name, _magic, _prog_addr, _reh_addr) \
>> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
>> +					    struct device_attribute *attr, \
>> +					    char *buf) \
>> +{ return show_root_entry_hash(dev, _magic, _prog_addr, _reh_addr, buf); } \
>> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
>> +
>> +DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>> +DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>> +DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>> +
>> +static struct attribute *m10bmc_security_attrs[] = {
>> +	&dev_attr_bmc_root_entry_hash.attr,
>> +	&dev_attr_sr_root_entry_hash.attr,
>> +	&dev_attr_pr_root_entry_hash.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group m10bmc_security_attr_group = {
>> +	.name = "security",
>> +	.attrs = m10bmc_security_attrs,
>> +};
>> +
>> +static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>> +	&m10bmc_security_attr_group,
>> +	NULL,
>> +};
>> +
>> +#define SEC_UPDATE_LEN_MAX 32
>> +static int m10bmc_sec_probe(struct platform_device *pdev)
>> +{
>> +	struct m10bmc_sec *sec;
>> +
>> +	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>> +	if (!sec)
>> +		return -ENOMEM;
>> +
>> +	sec->dev = &pdev->dev;
>> +	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>> +	dev_set_drvdata(&pdev->dev, sec);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct platform_device_id intel_m10bmc_sec_ids[] = {
>> +	{
>> +		.name = "n3000bmc-sec-update",
>> +	},
>> +	{ }
>> +};
> Please move the MODULE_DEVICE_TABLE() here, without blank lines.

OK - will do.

Thanks for the comments!
- Russ

> Thanks, Yilun
>> +
>> +static struct platform_driver intel_m10bmc_sec_driver = {
>> +	.probe = m10bmc_sec_probe,
>> +	.driver = {
>> +		.name = "intel-m10bmc-sec-update",
>> +		.dev_groups = m10bmc_sec_attr_groups,
>> +	},
>> +	.id_table = intel_m10bmc_sec_ids,
>> +};
>> +module_platform_driver(intel_m10bmc_sec_driver);
>> +
>> +MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.25.1

