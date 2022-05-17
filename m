Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7E52AC99
	for <lists+linux-fpga@lfdr.de>; Tue, 17 May 2022 22:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbiEQUQy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 May 2022 16:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiEQUQx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 May 2022 16:16:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C9517FF;
        Tue, 17 May 2022 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652818611; x=1684354611;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JKh3Go0SkLU+V3NBzdUvOWFJh/p+N/oDcQp9kMH/pZw=;
  b=MoxrGdZ5bbYK6SiRHhQEUXQEo38xvGQNpzzL4xW8HsTV5pIHKUnJ9UPP
   5HaE1f9UfgB2rShGX1aDYf0A8EyzyHAyEwN2wYwqM7CaRIDJW94KS/tac
   m8+SeasTaI3ObHuTdKsvpY97o1WoujTJJyJ0xwPLPajLMWvANRCGuLoAJ
   +Fxbt0vMcB0kFHz2zmNkNOc3dX0sfJgDrXCniPBXkj2h/Vhaw5uXprHMs
   xv6xBpmSZ+vbxzQz8SQkH6UCIJjc81CldtFi93zOP78IEYspnqal9cSrX
   6eOW0iF2w03OZLrUUdOykU7bCU+ShsMPYWP3Arx9VetZriCG8YMKC/N4P
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="296603173"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="296603173"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 13:16:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="817067589"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2022 13:16:51 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 13:16:50 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 13:16:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 13:16:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 13:16:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey6jj29EEqfGDmtiGDpko4VPMjmmrbZ+Vz59MPUDk2kJIPzdjSuI3WHbL/itfsg/S2IbuPnOKQQboCksLAjcFjkQg08ae3OqiHFkIY9NgkHZxF6hglDj5LOqPEeehCFcW6KP/FvLCB+R+4uezW6fWwxeNqF3YG7gLzjlhwko6S/8XkJ+5v+FzXoOzwzzf4/p+r/YmiU5t+ojaOmUMQt43HDFDSVrj07fwFdusKq6Y7lJ5KYTgxtfQf+98IOrHS9OPe+x4I0PJpkcyz6c+mbWRHGQ5AZ7EvjsxxkcanCKGThz8FHt/tw6KEWkFxRRqnTvez2JXCLHeEZP9rR6C9IV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkEecO3vdqtTpKoxuoiMtJC9HXrtL6Pz2JkddY+U820=;
 b=eSF1c6iECVosVyUTnwd264gifP9w+ydPBKQSLV7+GXDjmk88xq6KPjkWcnR784feekwmB+NJC0Iq8rDuNU+vQebjlRrww5/POMQyvKZSvIzKidF4Tx8ij0KioMQcxBoNpMNytUs/7ROAAPW9zqPGaCa8PJfgMv7Pyl2lycx2WpCC+xJzJoLrdoLwsvHkgrdJ99U6ki1HEYlqU94j/F+YVI7IxbEi0ZVZFlI0HWbodiOUtbqdjzTJQOhErQ9Wosd1mpvd5twj66G8syP7QBPWDXnP1WYMV3M7UJ6qwShsr0BOOTEohEc7MZi2MRo0LR7Zj5RYvcVnsODUtoqX1Qe1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by SN6PR11MB3424.namprd11.prod.outlook.com (2603:10b6:805:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 20:16:46 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 20:16:46 +0000
Message-ID: <4886d75f-f055-accf-9df0-c6e12f901a51@intel.com>
Date:   Tue, 17 May 2022 13:16:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v20 5/5] fpga: m10bmc-sec: add max10 secure update
 functions
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <lee.jones@linaro.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <marpagan@redhat.com>, <lgoncalv@redhat.com>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220516234941.592886-1-russell.h.weight@intel.com>
 <20220516234941.592886-6-russell.h.weight@intel.com>
 <20220517094824.GC40711@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220517094824.GC40711@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81cb3e96-e9da-4b56-78a3-08da38422a78
X-MS-TrafficTypeDiagnostic: SN6PR11MB3424:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB342431AB8C8481176BA4A681C5CE9@SN6PR11MB3424.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2QGFWy159bp4T2fxt23tgA7bD+TJu4ATNEYSmCNWYMhUSOUI443YidbxF1AohVGUcIDk+3NOi0SGeTBwcnIV3vjtgQfpRfnA2bdDCoFgI0LN2BKQbNrM/QDW+7FZ2UOWFEreutgH/WdwjKQpImk0ikZ+gL44xiVjbic0GaWFBxoPoq40hupYxPFPn4JxWNNZRS4vTuheVreXUM67sAcsB0EWo90IknDic1JIA2IOh02HLmuPWWV5IlJZFWailxH10q9LdPjKdq+oahnhsoAXrc9HViAPc1dPHAt0xOQYE/CJKBbC9EOxAJRXwV/Kga6fw8KdzUURmrqWEmiasNVVJ2PsK3YJ8OaEAxo42NyqJwXTfavQbEZeALrCPP2WsTsuCDxXcjgTC8HzzK3o658IDeuDgBxLPYSuiMsofRkfzXPQuPFXo5fSEtLHvWVa1b2gbBN9wrNW1vKwRRGDPpr/Eq7kFy+/wolrus1pA0sV/85bi7g+FKKKINy5ULX5LIei6u/p/FXDLzIEUzqCN9Is7L93qe9VF09prpwxGddC01lzOStJ6jY0vGVHVDXME8XheZ+axUNwBjwKwv/wbomgKDZZ9cBpT29kE6q9JM5E5Lbpte6f+jrBHL0aMoOapyuvoCoRA8JqebZ/P33oOVB5jaE+RZRVUQo92P2uBvtssfYd+R5c6oXB8Ey0wxq3H2GjawteZIyrwSmy9VgDpjqmQvP3uE0TvNim+OR0DKOPhaFhOEx6ZeKQB+SoEufY2XX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6512007)(86362001)(186003)(82960400001)(6862004)(4326008)(8676002)(66556008)(66476007)(31696002)(8936002)(83380400001)(15650500001)(31686004)(316002)(6666004)(6636002)(37006003)(53546011)(38100700002)(36756003)(508600001)(6506007)(5660300002)(2616005)(26005)(66946007)(2906002)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGk1dlVqRUV3QmtXWElqajBSZ2d2ampNK3JXV0M1a05YWnkxelNQckY1NGxy?=
 =?utf-8?B?d25wTkxvcldHUTlMNlZ3ZlhPQXZTRHQ5RUFIYWN4V0U4bDNlYjJlTWo4L1ZU?=
 =?utf-8?B?bzhYdWg5TWsyREdFKzQ4VDNweWNEbUc0dERvQmhvZVZ3aWJ2ZjlCME5DdzRQ?=
 =?utf-8?B?TUw0Z2thbEVQdHpEaXc3N2Q4Wm9UdzV6b01kOTFHc2xVcVdBRFRGVDBHLzZD?=
 =?utf-8?B?dnY1ckhaWHhqaHNuVWNtQVRvUncrVXJnQUVteHFod1RXdlppc3ZINlM5anFS?=
 =?utf-8?B?WkFFUjhpdjdGWUV4VHNRTEQ1dGJ6cEFwUDFoZ0lXeENQRjdxaHhMOFNadEpC?=
 =?utf-8?B?Vk5jRUEveE5EQi9zNzhrYlhqNk5ScCtrMllaV2lLV0xTL1B2M1dPaVhSVWVh?=
 =?utf-8?B?eGV1b2xBN0pyVzZBdGFLWUhjWERWRFoybkRNQWxxSElVdENYUVBGSjFsR1Rj?=
 =?utf-8?B?dkhieG02QjQvUi8zWGJyR2g2Q09OWGIvRDFPeGZwUDBSK3VNQThjeHBTN0g5?=
 =?utf-8?B?cEw2bkpBR255bzFtQmlVcytHYzlaNXVZS3J1NDZXeXNGRkg2NVBiSGFGd0Vx?=
 =?utf-8?B?YXJiT3puWW1iT0NJTHJyL21PSEFnckE3d0s4M3dGVnkzUzJtdThtdzJrNE5M?=
 =?utf-8?B?MjB1bUhYYjErS1c1UTNWM0h3WEoxdVBSblQ4bGdKUGoyK3gyby9YcDFvSXZV?=
 =?utf-8?B?eUZRNjdVRTlJWmVoenNDRXE1LzFTOFNjdVhIY0xHMHUwMUg5R25oMElrOEYv?=
 =?utf-8?B?N2wwVithTTFMYzIveGp5TUNGWVlJOVBvcU5GSTBLOU5NSFl4R2pMRkpjLzNm?=
 =?utf-8?B?WXRhUmFPbm1jdnVncFJ5SFRhTzM1Z3p5WXlSN2k5Z0ZRMmZIL0FQRGc5R09n?=
 =?utf-8?B?ZGZuVmloVkwvdjJFMjVpaHM3SzVsMk1qZE5rb2pRb3NQWnZYNlNkdE16WUd5?=
 =?utf-8?B?bk4rRGtiZ29vM2pPRWkzNjhkVVVGZ2p6b2FGeVpnYit6U0VoY0hZemM1aWxH?=
 =?utf-8?B?eklrRUZRMEh1VGR1R2VkVmR4S2VuZTZjdkRYUmNlWDhYbFlDSkFWSVhGR2J1?=
 =?utf-8?B?NmdnbkhMWmxYb3pIZFUzRDd3RVpYR1p2UElyVW0xY25EZ3dabEVGSGdMWFlN?=
 =?utf-8?B?cDRiREoxUlpRK0V2cUt5cnJlaTAzVXZCcE1sUXRxbVlpQml5S0pwdEw3a0hG?=
 =?utf-8?B?MElHb2NIYmx4WjUySnV0dGxyN1pVdVVjRTFRUkhPTVI1ZGJIN29YcEU1cm1C?=
 =?utf-8?B?ZmhGTC9oV1dySkYzRldtR0N6MXA1VjJVbXVOQ3J2ZStSY2pPTGtjRmQ5VFNG?=
 =?utf-8?B?R2p1Y2h4ZVNvekVlemU0Y1ZrODllU3F1ZlBQTkp0UE03YjV1VzczaUh0QVpx?=
 =?utf-8?B?MnNIc0U2K2pabThwcXNCMGREREgrbUZBa0JGcWJwMzBKWUZCeWtkNUM0TUor?=
 =?utf-8?B?aUxwbVpwZGhCSnVKaTk0ZS93TlQxelMydXRsY1RKYTdwYjZqWjVOa0hQNUps?=
 =?utf-8?B?ZlovdEdmTDZPOW11WllML0EydUFvQkJ0Ri82R0Z5Q3AvZmJnUHBWeXZ6STkw?=
 =?utf-8?B?T25YLy9xUThWT2szV1FDOTRLbEVNN0JwRUNUYWVWMkFQc245UDVFVE8xYmQv?=
 =?utf-8?B?MSs1ZXJqK3hvaUo3MnllUitSYmhIZWpNaVAyZW52TlNaaXVyUDZqUmx4RHBa?=
 =?utf-8?B?Y1loY1VyMkgzaWtveFZiMURhK1NpUUUwV0lROWxZVUhscXNLNmlCSlVhVzgw?=
 =?utf-8?B?TWR6eWRCaTVRWGNlcTdsTEEveUwwVGExY1JhejFDbU8vQ055R0J5Yk9WZFJi?=
 =?utf-8?B?MmNsSXYraHBYRThSUExyaHRmMzEzMlFrQmZ4czZ6THlpU0dNejhFYi93RGRH?=
 =?utf-8?B?MFIzZ2dlcEJVNkttTE56eE5lZjk4bnY3aWdYaGl0a1VNaDJ1cytjelpGOUdq?=
 =?utf-8?B?UUNFUDBDelhZSkVKQ2c5eTdSSUJwZUdTUFdESjVvSFhPYzAvOXdXZnlLVEVY?=
 =?utf-8?B?Yi9UNWtmQnRzQkdMN2ZkRTI1bnJoNUVNamo4ODRxTHkvYnF6dmpiYUxkVFl0?=
 =?utf-8?B?d3FBNHhSV3VldWhrR3J2bjZWVmx4cFB6SDJLbjQ4SXpGeWJmLzJTblZGZ2pz?=
 =?utf-8?B?bGZqZ0JaeGg0QXdJeGRoeGthTDdUY1QvSGt1L3U1VERuSzZHa0RQdFgyU2wr?=
 =?utf-8?B?a3Zpa0syaTEwdjhkM2MvSjFhekFxUWpHejRFV2RNZFU5ZDRMVXVjKzgzaE5X?=
 =?utf-8?B?RU1pY1F0cStHd2kzTHBzTEdQQ0ZSNG90TGd6VXRBdVEyT1U3NDZlcDcxSGY0?=
 =?utf-8?B?emRodWh3SjZJdzNFVmcxV2g3SThyZXRyU2RoUHFESjBRaFNWSFlYbVF1VG5Q?=
 =?utf-8?Q?r91Ycounqctl10BY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cb3e96-e9da-4b56-78a3-08da38422a78
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 20:16:45.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBNlVWtV0YieYug1yVwix4dB1kK6FpajoZM9RMRXNBE0JLBlYjBbyX8bvW3dMtMcQUKdKn6HxVvwJ+ycIushT7Zn9N8hax3sN+5gUkXkxxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3424
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/17/22 02:48, Xu Yilun wrote:
> On Mon, May 16, 2022 at 04:49:41PM -0700, Russ Weight wrote:
>> Create firmware upload ops and call the Firmware Upload support of the
>> Firmware Loader subsystem to enable FPGA image uploads for secure
>> updates of BMC images, FPGA images, etc.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v20:
>>   - No change.
>> v19:
>>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>>     with the parent driver.
>> v18:
>>   - Moved the firmware_upload_register() function here from an earlier
>>     patch since this is where the required ops are provided.
>>   - Moved the bmc_sec_remove() function here from an earlier patch to
>>     unregister the firmware driver and do cleanup.
>> v17:
>>   - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
>>     future devices will not necessarily use the MAX10.
>>   - Change from image_load class driver to the new firmware_upload 
>>     functionality of the firmware_loader.
>>   - fw_upload_ops functions will return "enum fw_upload_err" data types
>>     instead of integer values.
>> v16:
>>   - Use 0 instead of FPGA_IMAGE_ERR_NONE to indicate success.
>>   - The size alignment check was moved from the FPGA Image Load framework
>>     to the prepare() op.
>>   - Added cancel_request boolean flag to struct m10bmc_sec.
>>   - Moved the RSU cancellation logic from m10bmc_sec_cancel() to a new
>>     rsu_cancel() function.
>>   - The m10bmc_sec_cancel() function ONLY sets the cancel_request flag.
>>     The cancel_request flag is checked at the beginning of the
>>     m10bmc_sec_write() and m10bmc_sec_poll_complete() functions.
>>   - Adapt to changed prototypes for the prepare() and write() ops. The
>>     m10bmc_sec_write_blk() function has been renamed to
>>     m10bmc_sec_write().
>>   - Created a cleanup() op, m10bmc_sec_cleanup(), to attempt to cancel an
>>     ongoing op during when exiting the update process.
>> v15:
>>   - Adapted to changes in the FPGA Image Load framework:
>>     (1) All enum types (progress and errors) are now type u32
>>     (2) m10bmc_sec_write_blk() adds *blk_size and max_size parameters
>>         and uses *blk_size as provided by the caller.
>>     (3) m10bmc_sec_poll_complete() no long checks the driver_unload
>>         flag.
>> v14:
>>   - Changed symbol names to reflect the renaming of the Security Manager
>>     Class driver to FPGA Image Load.
>> v13:
>>   - No change
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>>   - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
>>     no longer has a size parameter, and the block size is determined
>>     in this (the lower-level) driver.
>> v11:
>>   - No change
>> v10:
>>   - No change
>> v9:
>>   - No change
>> v8:
>>   - Previously patch 5/6, otherwise no change
>> v7:
>>   - No change
>> v6:
>>   - Changed (size / stride) calculation to ((size + stride - 1) / stride)
>>     to ensure that the proper count is passed to regmap_bulk_write().
>>   - Removed unnecessary call to rsu_check_complete() in
>>     m10bmc_sec_poll_complete() and changed while loop to
>>     do/while loop.
>> v5:
>>   - No change
>> v4:
>>   - No change
>> v3:
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>     driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>>   - Changed calling functions of functions that return "enum fpga_sec_err"
>>     to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
>> v2:
>>   - Reworked the rsu_start_done() function to make it more readable
>>   - Reworked while-loop condition/content in rsu_prog_ready()
>>   - Minor code cleanup per review comments
>>   - Added a comment to the m10bmc_sec_poll_complete() function to
>>     explain the context (could take 30+ minutes to complete).
>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>>   - Moved MAX10 BMC address and function definitions to a separate
>>     patch.
>> ---
>>  drivers/fpga/intel-m10-bmc-sec-update.c | 377 ++++++++++++++++++++++++
>>  1 file changed, 377 insertions(+)
>>
>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
>> index 6c39adc6492d..a4dc5f47e398 100644
>> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>> @@ -17,8 +17,14 @@
>>  struct m10bmc_sec {
>>  	struct device *dev;
>>  	struct intel_m10bmc *m10bmc;
>> +	struct fw_upload *fwl;
>> +	char *fw_name;
>> +	u32 fw_name_id;
>> +	bool cancel_request;
>>  };
>>  
>> +static DEFINE_XARRAY_ALLOC(fw_upload_xa);
>> +
>>  /* Root Entry Hash (REH) support */
>>  #define REH_SHA256_SIZE		32
>>  #define REH_SHA384_SIZE		48
>> @@ -179,9 +185,349 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>>  	NULL,
>>  };
>>  
>> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>> +{
>> +	u32 auth_result;
>> +
>> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
>> +
>> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
>> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
>> +}
>> +
>> +static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
>> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_BUSY;
>> +	}
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static inline bool rsu_start_done(u32 doorbell)
>> +{
>> +	u32 status, progress;
>> +
>> +	if (doorbell & DRBL_RSU_REQUEST)
>> +		return false;
>> +
>> +	status = rsu_stat(doorbell);
>> +	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
>> +		return true;
>> +
>> +	progress = rsu_prog(doorbell);
>> +	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell, status;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
>> +				 DRBL_RSU_REQUEST |
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_IDLE));
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				       doorbell,
>> +				       rsu_start_done(doorbell),
>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>> +
>> +	if (ret == -ETIMEDOUT) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_TIMEOUT;
>> +	} else if (ret) {
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +	}
>> +
>> +	status = rsu_stat(doorbell);
>> +	if (status == RSU_STAT_WEAROUT) {
>> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
>> +		return FW_UPLOAD_ERR_WEAROUT;
>> +	} else if (status == RSU_STAT_ERASE_FAIL) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
>> +{
>> +	unsigned long poll_timeout;
>> +	u32 doorbell, progress;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
>> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
>> +		msleep(RSU_PREP_INTERVAL_MS);
>> +		if (time_after(jiffies, poll_timeout))
>> +			break;
>> +
>> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +		if (ret)
>> +			return FW_UPLOAD_ERR_RW_ERROR;
>> +	}
>> +
>> +	progress = rsu_prog(doorbell);
>> +	if (progress == RSU_PROG_PREPARE) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_TIMEOUT;
>> +	} else if (progress != RSU_PROG_READY) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_HOST_STATUS,
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_WRITE_DONE));
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				       doorbell,
>> +				       rsu_prog(doorbell) != RSU_PROG_READY,
>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>> +
>> +	if (ret == -ETIMEDOUT) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_TIMEOUT;
>> +	} else if (ret) {
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +	}
>> +
>> +	switch (rsu_stat(doorbell)) {
>> +	case RSU_STAT_NORMAL:
>> +	case RSU_STAT_NIOS_OK:
>> +	case RSU_STAT_USER_OK:
>> +	case RSU_STAT_FACTORY_OK:
>> +		break;
>> +	default:
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
>> +{
>> +	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
>> +		return -EIO;
>> +
>> +	switch (rsu_stat(*doorbell)) {
>> +	case RSU_STAT_NORMAL:
>> +	case RSU_STAT_NIOS_OK:
>> +	case RSU_STAT_USER_OK:
>> +	case RSU_STAT_FACTORY_OK:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (rsu_prog(*doorbell)) {
>> +	case RSU_PROG_IDLE:
>> +	case RSU_PROG_RSU_DONE:
>> +		return 0;
>> +	case RSU_PROG_AUTHENTICATING:
>> +	case RSU_PROG_COPYING:
>> +	case RSU_PROG_UPDATE_CANCEL:
>> +	case RSU_PROG_PROGRAM_KEY_HASH:
>> +		return -EAGAIN;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
>> +		return FW_UPLOAD_ERR_BUSY;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_HOST_STATUS,
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_ABORT_RSU));
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	return FW_UPLOAD_ERR_CANCELED;
>> +}
>> +
>> +static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
>> +					     const u8 *data, u32 size)
>> +{
>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>> +	u32 ret;
>> +
>> +	sec->cancel_request = false;
>> +
>> +	if (!size || size & 0x3 || size > M10BMC_STAGING_SIZE)
> Why the size should be 4 bytes aligned? I assume this relates to max10
> register stride. If so, I suggest we don't use instant number here.

This check was not related to stride. All of the image files for these
devices are 4-byte aligned. I suppose there is no reason to enforce this
as the BMC will detect if a secure image is invalid. I can remove this
check.

>> +		return FW_UPLOAD_ERR_INVALID_SIZE;
>> +
>> +	ret = rsu_check_idle(sec);
>> +	if (ret != FW_UPLOAD_ERR_NONE)
>> +		return ret;
>> +
>> +	ret = rsu_update_init(sec);
>> +	if (ret != FW_UPLOAD_ERR_NONE)
>> +		return ret;
>> +
>> +	ret = rsu_prog_ready(sec);
>> +	if (ret != FW_UPLOAD_ERR_NONE)
>> +		return ret;
>> +
>> +	if (sec->cancel_request)
>> +		return rsu_cancel(sec);
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +#define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
>> +
>> +static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data,
>> +					   u32 offset, u32 size, u32 *written)
>> +{
>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> reverse xmax tree please.
OK - I'll fix it.
>
>> +	u32 blk_size, doorbell;
>> +	int ret;
>> +
>> +	if (sec->cancel_request)
>> +		return rsu_cancel(sec);
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret) {
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	}
>> +
>> +	blk_size = min_t(u32, WRITE_BLOCK_SIZE, size);
>> +	ret = regmap_bulk_write(sec->m10bmc->regmap,
>> +				M10BMC_STAGING_BASE + offset,
>> +				(void *)data + offset,
>> +				(blk_size + stride - 1) / stride);
> You mean to DIV_ROUND_UP the write size here? So you may write more
> bytes than required?
>
> Also possible to access out of bounds for 'data', is it?

All of the writes, except possibly the last write, will be of size
WRITE_BLOCK_SIZE, which is page aligned. Only the last write could
potentially round up on the stride. We have already verified that
the data written will fit in the staging area (in the prepare function),
so additional bytes to complete the stride will not exceed the staging
area which is the target for these writes.

>> +
>> +	if (ret)
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +	*written = blk_size;
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static enum fw_upload_err m10bmc_sec_poll_complete(struct fw_upload *fwl)
>> +{
>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>> +	unsigned long poll_timeout;
>> +	u32 doorbell, result;
>> +	int ret;
>> +
>> +	if (sec->cancel_request)
>> +		return rsu_cancel(sec);
>> +
>> +	result = rsu_send_data(sec);
>> +	if (result != FW_UPLOAD_ERR_NONE)
>> +		return result;
>> +
>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
>> +	do {
>> +		msleep(RSU_COMPLETE_INTERVAL_MS);
>> +		ret = rsu_check_complete(sec, &doorbell);
>> +	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
>> +
>> +	if (ret == -EAGAIN) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_TIMEOUT;
>> +	} else if (ret == -EIO) {
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +	} else if (ret) {
>> +		log_error_regs(sec, doorbell);
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +/*
>> + * m10bmc_sec_cancel() may be called asynchronously with an on-going update.
>> + * All other functions are called sequentially in a single thread. To avoid
>> + * contention on register accesses, m10bmc_sec_cancel() must only update
>> + * the cancel_request flag. Other functions will check this flag and handle
>> + * the cancel request synchronously.
>> + */
>> +static void m10bmc_sec_cancel(struct fw_upload *fwl)
>> +{
>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>> +
>> +	sec->cancel_request = true;
> Do we need some atomic_xx functions to ensure concurrent correctness?

In the context of an update, this is once-written and only if the secure update
is cancelled. We are only checking true vs false so I don't think atomicity
is an issue. Do you recommend that I use atomic_read() and atomic_write() for
the cancel_request flag?

>
>> +}
>> +
>> +static void m10bmc_sec_cleanup(struct fw_upload *fwl)
>> +{
>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>> +
>> +	(void)rsu_cancel(sec);
>> +}
>> +
>> +static const struct fw_upload_ops m10bmc_ops = {
>> +	.prepare = m10bmc_sec_prepare,
>> +	.write = m10bmc_sec_write,
>> +	.poll_complete = m10bmc_sec_poll_complete,
>> +	.cancel = m10bmc_sec_cancel,
>> +	.cleanup = m10bmc_sec_cleanup,
>> +};
>> +
>>  #define SEC_UPDATE_LEN_MAX 32
>>  static int m10bmc_sec_probe(struct platform_device *pdev)
>>  {
>> +	char buf[SEC_UPDATE_LEN_MAX];
>> +	struct fw_upload *fwl;
>> +	unsigned int len, ret;
> Why the ret is unsigned int?
I will change it to int.

>
>>  	struct m10bmc_sec *sec;
>>  
>>  	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>> @@ -192,6 +538,36 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
>>  	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>>  	dev_set_drvdata(&pdev->dev, sec);
>>  
>> +	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
>> +		       xa_limit_32b, GFP_KERNEL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
>> +			sec->fw_name_id);
>> +	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
> Should we check this memory allocation?
Yes! - I'll add a check.

Thanks for the review.
- Russ
>
> Thanks,
> Yilun
>
>> +
>> +	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
>> +				       &m10bmc_ops, sec);
>> +	if (IS_ERR(fwl)) {
>> +		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
>> +		kfree(sec->fw_name);
>> +		xa_erase(&fw_upload_xa, sec->fw_name_id);
>> +		return PTR_ERR(fwl);
>> +	}
>> +
>> +	sec->fwl = fwl;
>> +	return 0;
>> +}
>> +
>> +static int m10bmc_sec_remove(struct platform_device *pdev)
>> +{
>> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
>> +
>> +	firmware_upload_unregister(sec->fwl);
>> +	kfree(sec->fw_name);
>> +	xa_erase(&fw_upload_xa, sec->fw_name_id);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -205,6 +581,7 @@ MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
>>  
>>  static struct platform_driver intel_m10bmc_sec_driver = {
>>  	.probe = m10bmc_sec_probe,
>> +	.remove = m10bmc_sec_remove,
>>  	.driver = {
>>  		.name = "intel-m10bmc-sec-update",
>>  		.dev_groups = m10bmc_sec_attr_groups,
>> -- 
>> 2.25.1

