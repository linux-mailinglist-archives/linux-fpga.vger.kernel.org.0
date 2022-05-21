Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787AA52F6F1
	for <lists+linux-fpga@lfdr.de>; Sat, 21 May 2022 02:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354274AbiEUAhs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 20 May 2022 20:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352827AbiEUAhp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 20 May 2022 20:37:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63B18AA99;
        Fri, 20 May 2022 17:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653093464; x=1684629464;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ALWOfmTyZLa4ONpTPhtRWjhcakn0H/t89Z1/77iiA+Y=;
  b=Klq9li/Kp0fKBntXPmEfB5vncPg6ZH/F5zj3YUqhjQHyWCmFRGSh09gB
   hjMbDpK73f3OjTurMBIuIWnBffraSAJb/rhKJNdNDtnx7s0Z/GFpHWLbJ
   2Hknb1dDD1sGb70MVhofEN6rRNxOyPk18Il4XhUfvnasNznVol6QdZCEI
   qO/RhtG7ELeIWPm9ibYsF2pTjJLQOFT1iZc138dHlTbE82uzLbJRYTCwX
   9aiP/AFJR1VaybJb6j3ElJi7BS1a7H3SfK4O8pIkN6RpfuS6kMVmNFjHJ
   mmW3NZyq87afMIKMJAcmgXls5XSWmV63GtxyghS1QUgihZrB0FLQSupMf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="253295051"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="253295051"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 17:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="599520358"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 20 May 2022 17:37:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 20 May 2022 17:37:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 20 May 2022 17:37:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 20 May 2022 17:37:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 20 May 2022 17:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KY7LQL9uPg5SS3PO6cn4/JW9E4BmNYrmkntMQjn2sDbDtWkEFBejNRy5AyUiu82boynyHmpjtQlIgMJK2svCiYftwoL3RmufpMUzxcKXT1NkaoChrUkxaF40xtL5C1eFuO8xauFzc/GFQg0cj2nlCfcX2dq+JVBdgdmJXM0hj1fFjXfd5w95CW591UNNAwWcaZYI0PQLEatl1t6qApSMOw+Mpdkj/btb40D2dnh2xph2FBK1Ahs5TmpoOE2x2zRpSV9m+X4/rUSUMRRmx8xf/I/wlltkdpQrBJ3sboL5mOaFvlkO3rSyDDbbNNsIXoTUo+FKTtuZ9jQcplR/dUrx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cY79fSSY6jXgtB988vvEMZNmwcKEr/L5TWGdndzLHQ=;
 b=AYPCbr942kl8VzWmMjFuGFxuEyg4Yx4Vr0VRjPeSJHYEBgBfrWvlQDVF6efc7zbdO7qyIW9Gnwj0dSWui7E/HfdHj7gnHks6kkId6ZXZ9xyMNMzzt3cY0Mh2rvV3ap0l6G3hLbnzbfZ47gyq1VWq//jnMOEuJLmu71lSoy8fM5K7jk1U+MzzvmpkJUCeNIhCm4X8UROeE4cW+JZmwJ5HjDOynAaumQyJSrQ6Hh3bryr+v7vmZ25K185tAqBDJANYNrNqXfQxZPMqcQhimcjaQvk3GQus6af6cRgVKSKQ60wnSJwVCIkT7xLy0QjLjGR5qlaJXP5cKie5UteVB3XEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by CH2PR11MB4406.namprd11.prod.outlook.com (2603:10b6:610:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Sat, 21 May
 2022 00:37:41 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5273.016; Sat, 21 May 2022
 00:37:41 +0000
Message-ID: <58c1c480-3a67-1b0c-1d3c-c0014a4dc36f@intel.com>
Date:   Fri, 20 May 2022 17:37:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v20 3/5] fpga: m10bmc-sec: expose max10 flash update count
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <lee.jones@linaro.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <marpagan@redhat.com>, <lgoncalv@redhat.com>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220516234941.592886-1-russell.h.weight@intel.com>
 <20220516234941.592886-4-russell.h.weight@intel.com>
 <20220517041310.GA40711@yilunxu-OptiPlex-7050>
 <8fb5dea0-9ce6-a17c-1253-64a43c86c82c@intel.com>
 <20220518071010.GA55267@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220518071010.GA55267@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR04CA0144.namprd04.prod.outlook.com (2603:10b6:104::22)
 To DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab8396f8-bbd0-465e-c670-08da3ac21d08
X-MS-TrafficTypeDiagnostic: CH2PR11MB4406:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR11MB440674F7D5E5F19D26BBBE84C5D29@CH2PR11MB4406.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDYqBifnFnXVNpH5tx1EnljjZlQGjjhf4P4jT9tHypSWdgZFVTgmFt6lIjfcxOjw7kbIUjgCu1Gi5xJG2gjzRjIIxBqPCDvaZwfVVD5Dl9jahYr/MuIU1ImS4GY3V/nNbV/7LjMoLAshNp4B/jUng0Ny/L+2ug9jWAMAZzAVg9+PLIQbemRj/VejWzEMgNz1MxVgU7u+rwR9MaiQ2C80yRt0K8UCaJK5bv9FkZBywnR0oSDun8Crc/ZffoBdKMg7zL0DcTaRyKpebZCrcNQTGiPgB2Fz6VR+JrU0Tz3Wa2KlsMADyP3Jw/oOcSMInY3rO/vESmDpT7TVQ7WAUxqDGj7yY+69UJJVsPYb+WEjOcPVKH0m1UNv3lGt46apgZ/EM4v9xeJ287tJqnIei6E2Qs38ttyuxzWf7lOhXkofRC2FwDLkxQdaBxKvf7UW628tVpSOHPhCF7R7gMJbi1NCIx+wbezkX4NyvlejCywJO4fzLDiWoy00fjtM5Fsqg534hwKsUtG/B9oCvVIIK3YMBPNpcUWJsOOu+AUcCL6Ye+zB8X1/uvgeW0IxyAUfduLts3Hb2KY3C0q816T1LL3wmPG9JQ8yeXlBmI9pcGPCBLIBClsCKKaM3pyMxwib5Yt6S8RDZqkYBlR2TlqyEy+7ARa+QozUpxXQg6xSrjOv4NvTKaES9v+i5/VTug8LlwgYFO8g+nxKuZi19WoFqg0WzsPVg1RVEGxXYT4a2xSRaL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(15650500001)(6486002)(26005)(66556008)(53546011)(2906002)(508600001)(5660300002)(66946007)(8936002)(6512007)(31696002)(37006003)(6636002)(2616005)(6666004)(66476007)(6506007)(86362001)(8676002)(6862004)(4326008)(38100700002)(31686004)(83380400001)(36756003)(186003)(316002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1R5SDJOaStOVnlhaGNWMW85ZTh5MzBUZ1lkZm4xVTJOL05xMnpOOFJvY3Ux?=
 =?utf-8?B?WnhlS0x3aHA0cDdwalVUMnpmQkZjOThoZ0NKaDE5bnJPTTViTzlveHV3a04r?=
 =?utf-8?B?Ry9aenB5THNKb3dkMW00MTd6VDcwSlgyamtVVkgvYXpEb1IzZXlMN3NrSWRk?=
 =?utf-8?B?OS9NcjFJU3RzSjVzeXhSa2h4aGRyYXU5VGR6YlJaRnQ4OUNEMUdzbUZubno3?=
 =?utf-8?B?WXlpOEhNcmhONDN6NjRRRXZlMmxMeEplaS9NdFFHQUpJdmhuUEE1Q3VPbWor?=
 =?utf-8?B?eDN1VGh4QVZNYTZFNEUxWWJ3MG13UU84LzYvSU5wWHczZFJFYk5TTlRkNzMw?=
 =?utf-8?B?YlNOanlCZEJySnZLdERKWXNNUVZLY2hqakM4ZXBDeVpsUEg3M2ZTSE5Jcitr?=
 =?utf-8?B?VlNrQk1BMmMwQ0R3dnJGbzk1aXhINEFFbzhybkRFU09wUlVQeWZyQjB0dVp2?=
 =?utf-8?B?SVk2WjB1aUZpdkZsYW9oTUpWRmFCZ0RLNEpvUm9qNDV1L1hwckRrTi9XUUFv?=
 =?utf-8?B?bUlxbDlFS0FaRUl2V0Q5MVBDZVNtYXlBUXM1TTlTQmZqaStRM2ltSkNIUWI5?=
 =?utf-8?B?YWhENHV5aW90YmNSMVBqZ3BObjNidkd4MlZ3eFJCTmtMa2NqQmNQcTVNNkox?=
 =?utf-8?B?KytFODl0Nk9YbGVMVW1OKzlYWFhxLzk5WER6emNDOENua1B2amdESWFwWEpJ?=
 =?utf-8?B?bEtoK0Z5NU85K2sxWlpBSHJFMGtpSURwUXk1MmRmR052ZlJJcUNCTXlQN0Q0?=
 =?utf-8?B?N1N5d3pNTmdkQnVKRjh4RW9KSlY0Y2pxSlRUNXhNdDY4ajlTSU9qcDRlODUz?=
 =?utf-8?B?aWh6c2I4c3FIRTVGNnRLbC90T2VIL0JiZlJPeHYvbUNsUFVva1YzaTg1bUNM?=
 =?utf-8?B?cHRvc3lWdzk0Y1ovU3FGaFRuS1pxdXNlc2ZXcVNLNHpLendkSlJ2aUZ0REo3?=
 =?utf-8?B?bVk5eHdyRjJlSDBVYzlDNkZJeW5Gc20xNTVneHNIQi9PR1R6RUhWMFRxQnNl?=
 =?utf-8?B?RWN2OHlwdVVWU1FSQXo1T3pvVGVQSm9GMDduWmxzT3FLL0o4SHFQRDZlYnpr?=
 =?utf-8?B?YzhyVHhTVXBsRXIvWklaa0tBd2VqU2wwd2I0b2xrWjVDNTVCS2ZnSkNrZGFX?=
 =?utf-8?B?TlFsdXVaRjhUY21ZUmduZllXNytXWmRINmYvb2YvQ3ZoQlE2MHV0Q1Uzb0U1?=
 =?utf-8?B?UGsyejIzM08zMXptRHhGTE9YQU5RRXZ2UGNySkVURUFCcEYrUDBrNm5SODBu?=
 =?utf-8?B?YmxFWm9YaWxocHpKSkRSc2swZWZRZVFoNWtaYUU5NkkzY0FReTBKK0VnL0RD?=
 =?utf-8?B?OHNUZ1pKekc1eFZFRkVEWGl2UnhiL3lMTVdXYlpjdFFyczl6UHVYUHJlYkhP?=
 =?utf-8?B?NVZCUW1Cd0RUTlJyNUhRMnlNbjBmNUZybzd1VW1IWlRpMWpsc280ZmlwT2ky?=
 =?utf-8?B?aFQzdlFUa1lHTkd2K1h6SFo0OWx5VkdML251OUdsU0hpMGhnbGpxNlQ4ays3?=
 =?utf-8?B?R1hjSTUydHdyVDVaZXdNYytaZ3Y3TGpvWHhLT0JDKy8yVllhLzdZWk51Tmp3?=
 =?utf-8?B?UXV0T3ZZTWwxVjVEOGpIZDcwS3VKcitnVWt2V0NZdEg0Zm0vVjAxRUdKS21n?=
 =?utf-8?B?eWF2K2wxdy9PNG5BZTdoT2VQSmQwaFRoQW8xRHlwQUM0NnpJOGx4cmtPUG8z?=
 =?utf-8?B?K0xJOW5kWEY3U0xjaUs4TkV5Q3ZMOFk4RzBUajgySFNLT0VvL1pNS3V3a2gz?=
 =?utf-8?B?Wk54YlAwOTF5ZzJYN210eHpGU0c4ZDA0aS96SmpSWjJqNE51a1hnc3lmSUx0?=
 =?utf-8?B?Sm9TOHZkdmcxUTRNWjlyQTM2OXZEOHNGRTZzSW9qaDhDd0JyeG5rcVZGRXY0?=
 =?utf-8?B?SVYxZGVuMUg5N044ZEJvNkZLS292NkF3cEZBTU1kbXpuL1c5VUJYWjlvQWtj?=
 =?utf-8?B?alVFRUppcy9NMXUwLzNqTjU0KzRSSlNLWTA2ejlpaUIxS2YxNFJ1MWNHa1Y2?=
 =?utf-8?B?UjdIUmVVTU4vWklwWjZ6RWlXQjcvRzhzQVNFNjJLVWh1NDVJSzN6STMvNy85?=
 =?utf-8?B?eXh0Yi9mZC9mdVg3TnNYK3drZmpTVDRHSkpjQnFZREdDVGRsNmlpRnNDSzlX?=
 =?utf-8?B?bUw4VjFJV09leHl6VVhzTnJZd1dkUEVvZUlHY3VzcXMxNkxJN3AvU0ZJTzlt?=
 =?utf-8?B?ZUlGK3RHQUVQVjFsTHh5UUZWbGQ3VDB3MDk5V0Y3elh3L21UbDJqUjNOUnBI?=
 =?utf-8?B?NmpsMnUrSE15UFVCWHNmRDRsb3M0cHc3M1JRajlZZnZNZm5TNHBwS1d6ZlUx?=
 =?utf-8?B?TzhPUkMxVThMMDBrbzA2MHJrcXNaSDRUWWhOZERBN1Noa3VjVUFvTWRtNG51?=
 =?utf-8?Q?w35PhvnGXsmXjUhg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8396f8-bbd0-465e-c670-08da3ac21d08
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2022 00:37:41.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+EVstnA5PihldLbnQ66yvmtCrFhThF9deiDDOymiAOaKf4dN1w9LSWx3KK79e+41KQPYEZeFiG8C6dCbcvdpEGhM72sUVcNKFdEsdsZoPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4406
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/18/22 00:10, Xu Yilun wrote:
> On Tue, May 17, 2022 at 09:16:50AM -0700, Russ Weight wrote:
>>
>> On 5/16/22 21:13, Xu Yilun wrote:
>>> On Mon, May 16, 2022 at 04:49:39PM -0700, Russ Weight wrote:
>>>> Extend the MAX10 BMC Secure Update driver to provide a sysfs file to
>>>> expose the flash update count.
>>>>
>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> Reviewed-by: Tom Rix <trix@redhat.com>
>>>> ---
>>>> v20:
>>>>   - No change
>>>> v19:
>>>>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>>>>     with the parent driver.
>>>> v18:
>>>>   - No change
>>>> v17:
>>>>   - Update the Date and KernelVersion for the ABI documentation to Jul 2022
>>>>     and 5.19 respectively.
>>>>   - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
>>>>     future devices will not necessarily use the MAX10.
>>>> v16:
>>>>   - No Change
>>>> v15:
>>>>   - Updated the Dates and KernelVersions in the ABI documentation
>>>> v14:
>>>>   - No change
>>>> v13:
>>>>   - Updated ABI documentation date and kernel version
>>>> v12:
>>>>   - Updated Date and KernelVersion fields in ABI documentation
>>>> v11:
>>>>   - No change
>>>> v10:
>>>>   - Changed the path expression in the sysfs documentation to
>>>>     replace the n3000 reference with something more generic to
>>>>     accomodate other devices that use the same driver.
>>>> v9:
>>>>   - Rebased to 5.12-rc2 next
>>>>   - Updated Date and KernelVersion in ABI documentation
>>>> v8:
>>>>   - Previously patch 3/6, otherwise no change
>>>> v7:
>>>>   - Updated Date and KernelVersion in ABI documentation
>>>> v6:
>>>>   - Changed flash_count_show() parameter list to achieve
>>>>     reverse-christmas tree format.
>>>>   - Added WARN_ON() call for (FLASH_COUNT_SIZE / stride) to ensure
>>>>     that the proper count is passed to regmap_bulk_read().
>>>> v5:
>>>>   - Renamed sysfs node user_flash_count to flash_count and updated the
>>>>     sysfs documentation accordingly.
>>>> v4:
>>>>   - Moved the sysfs file for displaying the flash count from the
>>>>     FPGA Security Manager class driver to here. The
>>>>     m10bmc_user_flash_count() function is removed and the
>>>>     functionality is moved into a user_flash_count_show()
>>>>     function.
>>>>   - Added ABI documentation for the new sysfs entry
>>>> v3:
>>>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>>>     driver"
>>>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>>>     underlying functions are now called directly.
>>>> v2:
>>>>   - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
>>>>   - Minor code cleanup per review comments
>>>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>>>> ---
>>>>  .../sysfs-driver-intel-m10-bmc-sec-update     |  8 +++++
>>>>  drivers/fpga/intel-m10-bmc-sec-update.c       | 36 +++++++++++++++++++
>>>>  2 files changed, 44 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>>>> index 2bb271695e14..1132e39b2125 100644
>>>> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>>>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>>>> @@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
>>>>  		"hash not programmed".  This file is only visible if the
>>>>  		underlying device supports it.
>>>>  		Format: string.
>>>> +
>>>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
>>>> +Date:		Jul 2022
>>>> +KernelVersion:	5.19
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Read only. Returns number of times the secure update
>>>> +		staging area has been flashed.
>>>> +		Format: "%u".
>>>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> index f9f39d2cfe5b..3f183202de3b 100644
>>>> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> @@ -78,7 +78,43 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>>>>  DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>>>>  DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>>>>  
>>>> +#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
>>>> +
>>>> +static ssize_t flash_count_show(struct device *dev,
>>>> +				struct device_attribute *attr, char *buf)
>>>> +{
>>>> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>>>> +	unsigned int stride, num_bits;
>>>> +	u8 *flash_buf;
>>>> +	int cnt, ret;
>>>> +
>>>> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>>> +	num_bits = FLASH_COUNT_SIZE * 8;
>>>> +
>>>> +	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
>>>> +	if (!flash_buf)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	WARN_ON(FLASH_COUNT_SIZE % stride);
>>> The same concern here. Stop users from getting the broken value.
>> Sure - I will change this.
>>
>> I was using WARN_ON() because it indicates a problem in the device or
>> the driver itself. It is not really validating information from userspace.
> Understood. So it is OK we keep the WARN_ON, or WARN_ON_ONCE？But we
> should still have some code to handle the issue gracefully rather
> than just passing the broken value to user.
Yes, I have gone through each of these cases and made sure that they
return an error rather than garbage. I have also added kernel logging
in some cases.

Thanks,
- Russ
>
> Thanks
> Yilun
>
>> As I understand it, WARN_ON() is used to log such events to the kernel
>> log. If this isn't an appropriate use of WARN_ON(), then when should I
>> consider using it?
>>
>> Thanks,
>> - Russ
>>>> +	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
>>>> +			       flash_buf, FLASH_COUNT_SIZE / stride);
>>>> +	if (ret) {
>>>> +		dev_err(sec->dev,
>>>> +			"failed to read flash count: %x cnt %x: %d\n",
>>>> +			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
>>>> +		goto exit_free;
>>>> +	}
>>>> +	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
>>>> +
>>>> +exit_free:
>>>> +	kfree(flash_buf);
>>>> +
>>>> +	return ret ? : sysfs_emit(buf, "%u\n", cnt);
>>>> +}
>>>> +static DEVICE_ATTR_RO(flash_count);
>>>> +
>>>>  static struct attribute *m10bmc_security_attrs[] = {
>>>> +	&dev_attr_flash_count.attr,
>>>>  	&dev_attr_bmc_root_entry_hash.attr,
>>>>  	&dev_attr_sr_root_entry_hash.attr,
>>>>  	&dev_attr_pr_root_entry_hash.attr,
>>>> -- 
>>>> 2.25.1

