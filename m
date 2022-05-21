Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BAD52F72C
	for <lists+linux-fpga@lfdr.de>; Sat, 21 May 2022 02:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiEUAz4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 20 May 2022 20:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbiEUAzy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 20 May 2022 20:55:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8A511C25;
        Fri, 20 May 2022 17:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653094552; x=1684630552;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y05vepZMB72SvfmbyK9zHVe4jmkHsmXDWcb4Lp1Cjs8=;
  b=HPJt+K8Kq70e9ncssEe0r7T+AEFqWB1law5SJFfkG0tmF/nByP9afbR/
   9FxHnXFFKcBksTwk5YuBAWxN2/uOhuO7j4Z6fHvfJoJfnN5OXVExQiyNM
   Jhl935pBW2gfdpIsoZkHop1mbZf3qP8xi8GvVQaYqu6vkP8xECHXvwKM+
   KVEf7QyRGvC5dLh4hj8a4D7uF5mnf34LWVOh9D+oOBSvdXHLulG7x+3a0
   jb15S2YDJWfucxQmyoRjmEN09CT+oz9TmPBe8xHWx5B8tbdT0WReoQTO2
   vtB0HhIf4UpXiZCOxp1bAVjRNGeY0D8X9o6DJOR5h6HmbY6WAZ/bC35Vw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="253297132"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="253297132"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 17:55:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="546957610"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2022 17:55:51 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 20 May 2022 17:55:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 20 May 2022 17:55:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 20 May 2022 17:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goXOAR8/c4sTfruhW4rNp4ygRzYxsNGBisL+V/rUFJCrkPoVfT75CsTDX39Lsvgiz2/D/n1a1KmXMmZ8yDZi+UTeH/YcUkovzfwFR9s7X3rcnL1M2IXn5t9AVG9KoRNn/q0ey0e/J76simXSxDm0cEkVW7Uy52PNAfl31autzkARr42aY1EdZ2iC/DqEg5ojQtrenNb1TzZjNHnzruJyom0imOyFoW7niIE8E3kujgZ5/lLVqWXgad0nCR+/U5db53Rqqf3uNyHCMp9cAo9EaQ+b1Pom3f88039+qmmZJ/doHRTFLccHWnZrbRCbUhIhh0yqmnOD1xZE87qA95jBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHCBpIe2/FsfjRUsaRqeu87GudJOE4oCGWf6rHXoQDU=;
 b=WlOhlBMpo+UiiurWu7qSv4uI2FGRVQ9T6icojzWT/kPiJAJwvNSTsvghgrCkNxVfxEy6Xb3gmzLb9zNOpUCIbGTue+tIV35N5UBOe0AWu2ukVfcgHTF1X6xmwhoszuYI6hvJHAjVq0kCFqigfeizsk9oJ9YMKYTI4ILTPYtRxTmrlOz4jVmzAGcpptnoATm73ZJK62E/n7Jlcl+/eheaDDXkdlJL5ug5CVv39MiB+cTk7IKonZ8mLlAke7hZQ8mMtJ1Zo7JyIgHm5kzS6MlgBV+nU3BV5V7r0ukG3nsparncY+1/9znTpAX0dseGjuchMOrH4vYDvmlNaLaiVoe3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BN9PR11MB5369.namprd11.prod.outlook.com (2603:10b6:408:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Sat, 21 May
 2022 00:55:48 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5273.016; Sat, 21 May 2022
 00:55:48 +0000
Message-ID: <d1ce8f4b-6085-f269-45b8-3f036fa94e5b@intel.com>
Date:   Fri, 20 May 2022 17:55:37 -0700
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
 <4886d75f-f055-accf-9df0-c6e12f901a51@intel.com>
 <20220518084059.GB55267@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220518084059.GB55267@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:102:1::19) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e05c19c-aeec-476d-369a-08da3ac4a4ab
X-MS-TrafficTypeDiagnostic: BN9PR11MB5369:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB5369F32871728C94BF6F6177C5D29@BN9PR11MB5369.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJgbIYGNHRFTPBCSlBzUon9OTlBHI8ZqInNP7YX7WeiWsiRmkT+BDdvCJITevpD2MnPgRns5CW0LvgCyo6kH/mH4YA77LfD2AH/PUnvDd7XhFS7eFUOrTie+9sdwMqHT97fMPGOGpUZV3Flo+y+a4DYCe96qawxNI6j++CvBa/hdzs0bDDaKxOVk8vnvuGKVim8fHNTO/Z1d4Z2Ot1iKdkcvyGq5MtrIpx1ZDHm7FfAMSPijJphA6t6oeAKc0DgldmpHof2T59PW1kTCzTitMZCvZGpqQj490iYO/DwplP+3GCniLgwx8/7LobDbkSgfJhaGGWLJ6VbnGyh9LfHnS3Hp/wtKzS5ewpAHwUo9d10yMH6prtZ/wZg8DWKzafpegm/Ci2ooZcR/h8r5GaKo469AFhM00lhXNnB8+AnmnQpkhx5IyGZ6qaL/pcKlrPYs2irLNL69jvLD5rGepm+zkzOBnJUONxXTGrJ2NDTMDSuWJkAsn1z798KXKiqDgnGel4yvJH+ygIDyc1p6j62NfY58UOy/ewUTaYetCgqrc3mnX8OXH8fTrMvB07y1Z4P4Eaycit/eGYT8b27lUlMmWz5+XTjWOGBdcKtGZib69DZUkzWARSNetbVQ7VdDlVZUDwmyrtaRdrmgFk9jlWOyZtOwy4YgDZ1fRD2wbmsjrY/AARbFxjDU9BWuRHr7mbaxlIaRglCVjjPPglY1lVCxvSIivJNZphz1FUj550fcgcA8nOAge3EzfxT/J2awwIT4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(53546011)(6506007)(6862004)(6666004)(66946007)(66556008)(66476007)(26005)(6512007)(8676002)(86362001)(31696002)(6486002)(2616005)(508600001)(316002)(6636002)(37006003)(8936002)(186003)(83380400001)(82960400001)(38100700002)(36756003)(31686004)(30864003)(15650500001)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZIUFkwWEpDV090TUdLN2YrM3k5ZVRHcTBmZWFQcVlnQTBXalJ1dFRKQWtM?=
 =?utf-8?B?aTNLazZ1YVR2MllEVWRZbU1MMzJ1NGRvSVJ6UzNrVXA0amhhc0ZRczBIbzBi?=
 =?utf-8?B?d3FuSGxkb3prSlVXUmxMY0JuZkZ3U3dnMHRqU0J5bGY0aHh2MC9xcXVmdlpT?=
 =?utf-8?B?QTJqMzBzZ1ByTHFjdnE1WjlHMEpZMFpUL3lUc3d6ZForcE9uOE9ZYkhWUlZC?=
 =?utf-8?B?dHlSTHcyQXgveU5LTVdiejN1MHhYTzBBL3ZFRTZ2WFRueFNUSlltd2srZzE4?=
 =?utf-8?B?SmN4L1BYOHpxNTJCcmY1UVZUWTA1Wm1odXhnc1dhUU83S25zUWFoQWV5Qmlq?=
 =?utf-8?B?SE9ZRkZaVzg0MVZ5NytWQkk1OG5zMDMxRTgvMUFkSC9xVFZzcFB5ZHI1eXZK?=
 =?utf-8?B?Q1hMVnBBM1lYb21DaUJvdUE2UzdQNlkrekdFdktlNUZHVXQrT0hPRTBGVC85?=
 =?utf-8?B?Q2NzbUdqa0dOaWJnM2ZLYXNYUTh5ZXFpQWRPK2p4ZWNsd1QyZzI3MzRIdHJF?=
 =?utf-8?B?TCt3VEdNbWVFYW9LWklsdkNZRnBXSzR6NHZXLzI1NWd0VnVzQWI2ZTBHQVJj?=
 =?utf-8?B?QTg5VzlNVkp2bG1pVTNhaENGbU96eHM3RW9iR2tKbEZFa0hRZ1FycHAyelVl?=
 =?utf-8?B?SzV3amlmWitoc1VUcXpZQlVNSk1UcmRKTTBLVGxrZ0FxN3BMcTBMQlBNdktw?=
 =?utf-8?B?ejJqMXN2ODlTRDkrSzRRM1lCWlZCblg0V201N1FnUDNPTmhjR1lxUmlSanY5?=
 =?utf-8?B?b2FDZ0RQMXpXTmY3L2cxQTNNWGZlbmg2Uk95Um1DNm1lZW5rLzkrRVRpNmhL?=
 =?utf-8?B?VjAzalkrNTZYaGRpYWY3RXlQQTlGRUlqNWxlaUZ5enNrMThNMkQyOEVLUktX?=
 =?utf-8?B?VEdSMHAwdWszZFAyUTZKNExEUk83T0UveUcrZWQ4S0QzRzJ5bnR6Q2RyZHN6?=
 =?utf-8?B?bU9MMVNueFdjZW55SXI3cStzRmNPd0E0SnU3MDdneWpqR05MN2ZDS0Rzbnpn?=
 =?utf-8?B?SVpVZEhYNWpWK1JvMTRhM2hpZzcxTTIyLzR2NGwzMTk4aDVMLy94VEQwRGMy?=
 =?utf-8?B?RG1mUVhGK2MwdG9yaFBIWHZ3NkczU250V1hkMzljVzZScVZud0orNFhZM3Ey?=
 =?utf-8?B?YjNyRWtMOHNBb3lrOU9hYVluTC9JQzlhYzVjTUhqeUlqUVJGN0dBeEU0VTlv?=
 =?utf-8?B?b1ZDa2xOaEo2aWJjL2xCeTFaT1drM1lmWWhuSzRZZCtBVU41ZHl2Tm5uWTFC?=
 =?utf-8?B?b2RqdTQ3QndUenNIMFZRZ3duaEZmTmtqV1JxQ1ptdTdRa3daL3NkeHZFc1J3?=
 =?utf-8?B?OENyMVh1Q0R5ZElZS3RKZUs1aUxPTWIyc1dmUzNldTIwWkV3aUZuVVRJYnYv?=
 =?utf-8?B?RitSeXc0Z2hmSWc0aEtxSG5Qb3h5YzIxWW5Ra21IV2FmeTdrVE94bzlIakRB?=
 =?utf-8?B?ajloNGlYeEp0N3F0N3dVRjFwcGgyK2h5UkU4TDNNc1Npdkdkc0RWa2RkRXpj?=
 =?utf-8?B?MjJpV29VQjZualRNWjRJSVVzSTd3RkpncU5MRFRud1B0Y25HQXo1ZDUrMmFq?=
 =?utf-8?B?aE5Fc1k3dExWS3hNMWQ5ejZteWxUVHRzbkRsZ21qZmtyajMvZG10aS93SFU2?=
 =?utf-8?B?V09pbm55bmM5ZENOMzJaL3hJaVlxNkZQQSt1VDJTOUdGM3dxUFIyYTNndHRv?=
 =?utf-8?B?WVdJUU14MlA1N3lwc090a0xVTEhpdkdISnBEVmFPQklxOGRBZXJHNWs2eXBm?=
 =?utf-8?B?U2RDNFE5bk5HOGZWSnhhdUFuQWJRT1JrdzArYmRqcnMyei9Gd3NoNTBNL2tv?=
 =?utf-8?B?SUF6R1dZYUVLQzF1Q1JBY3ZxSFNYRFNTanVWTGpVTUZQaDVFdVRTb1ROZzV4?=
 =?utf-8?B?eDJNL2dtU2d6OUNXd0hyMTllZjNPSGxsMzF3NEd1QmthbU9nUEJUSlpRY3hZ?=
 =?utf-8?B?NmE3b2NUTGo4QTRGNHJyeFdhdmVqd1QzTkxoeFFkNTVQQjVvRkMrZFFWNU9P?=
 =?utf-8?B?Z0NOWXBvdWs4YjFrWElPVG5WdFE5WTJpSGREaHp0T2grZXBKV3hCVUpqTEc0?=
 =?utf-8?B?QTlRN0R0QkR5cGtEeUZKYW96MWJXWWgvV01jZkplKytFaVhxczRjUVdRRGZs?=
 =?utf-8?B?bXNOT1RsYnRtY1MrT1J5YkFTbUJqck5CZkN0bkltbVBhZmFXZTQzdWFzN01w?=
 =?utf-8?B?ZFhqWXpraEpzM21vamVJUFVBUWVpWUhMeWd0SHJyQkx4R1N2QVIzbUdQMzNL?=
 =?utf-8?B?NjRMUVpvTWFXdHl4UG9RbWpoSVF2WUhyK1hWMm9XN0plWFVnZ1I3QkNGRVpi?=
 =?utf-8?B?M3JPMWJCZUlnSWlXNDhSNTV2MjVZU0llU0NvKzhINFpNTHplVTl2MDQ5R0Ur?=
 =?utf-8?Q?Ge+45txTqK8Sxmb4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e05c19c-aeec-476d-369a-08da3ac4a4ab
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2022 00:55:47.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJ3Zbr6kfhK9aCbyr8qn3WbQgtcbfyJYTmXfkq3A2fqf4Ay3aGXfhyPXVilUpkar2oOnSxVpcdgD13QnNH52kGRwU0tDCjbvVg5KTa5QxI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5369
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



On 5/18/22 01:40, Xu Yilun wrote:
> On Tue, May 17, 2022 at 01:16:42PM -0700, Russ Weight wrote:
>>
>> On 5/17/22 02:48, Xu Yilun wrote:
>>> On Mon, May 16, 2022 at 04:49:41PM -0700, Russ Weight wrote:
>>>> Create firmware upload ops and call the Firmware Upload support of the
>>>> Firmware Loader subsystem to enable FPGA image uploads for secure
>>>> updates of BMC images, FPGA images, etc.
>>>>
>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> ---
>>>> v20:
>>>>   - No change.
>>>> v19:
>>>>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>>>>     with the parent driver.
>>>> v18:
>>>>   - Moved the firmware_upload_register() function here from an earlier
>>>>     patch since this is where the required ops are provided.
>>>>   - Moved the bmc_sec_remove() function here from an earlier patch to
>>>>     unregister the firmware driver and do cleanup.
>>>> v17:
>>>>   - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
>>>>     future devices will not necessarily use the MAX10.
>>>>   - Change from image_load class driver to the new firmware_upload 
>>>>     functionality of the firmware_loader.
>>>>   - fw_upload_ops functions will return "enum fw_upload_err" data types
>>>>     instead of integer values.
>>>> v16:
>>>>   - Use 0 instead of FPGA_IMAGE_ERR_NONE to indicate success.
>>>>   - The size alignment check was moved from the FPGA Image Load framework
>>>>     to the prepare() op.
>>>>   - Added cancel_request boolean flag to struct m10bmc_sec.
>>>>   - Moved the RSU cancellation logic from m10bmc_sec_cancel() to a new
>>>>     rsu_cancel() function.
>>>>   - The m10bmc_sec_cancel() function ONLY sets the cancel_request flag.
>>>>     The cancel_request flag is checked at the beginning of the
>>>>     m10bmc_sec_write() and m10bmc_sec_poll_complete() functions.
>>>>   - Adapt to changed prototypes for the prepare() and write() ops. The
>>>>     m10bmc_sec_write_blk() function has been renamed to
>>>>     m10bmc_sec_write().
>>>>   - Created a cleanup() op, m10bmc_sec_cleanup(), to attempt to cancel an
>>>>     ongoing op during when exiting the update process.
>>>> v15:
>>>>   - Adapted to changes in the FPGA Image Load framework:
>>>>     (1) All enum types (progress and errors) are now type u32
>>>>     (2) m10bmc_sec_write_blk() adds *blk_size and max_size parameters
>>>>         and uses *blk_size as provided by the caller.
>>>>     (3) m10bmc_sec_poll_complete() no long checks the driver_unload
>>>>         flag.
>>>> v14:
>>>>   - Changed symbol names to reflect the renaming of the Security Manager
>>>>     Class driver to FPGA Image Load.
>>>> v13:
>>>>   - No change
>>>> v12:
>>>>   - Updated Date and KernelVersion fields in ABI documentation
>>>>   - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
>>>>     no longer has a size parameter, and the block size is determined
>>>>     in this (the lower-level) driver.
>>>> v11:
>>>>   - No change
>>>> v10:
>>>>   - No change
>>>> v9:
>>>>   - No change
>>>> v8:
>>>>   - Previously patch 5/6, otherwise no change
>>>> v7:
>>>>   - No change
>>>> v6:
>>>>   - Changed (size / stride) calculation to ((size + stride - 1) / stride)
>>>>     to ensure that the proper count is passed to regmap_bulk_write().
>>>>   - Removed unnecessary call to rsu_check_complete() in
>>>>     m10bmc_sec_poll_complete() and changed while loop to
>>>>     do/while loop.
>>>> v5:
>>>>   - No change
>>>> v4:
>>>>   - No change
>>>> v3:
>>>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>>>     driver"
>>>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>>>     underlying functions are now called directly.
>>>>   - Changed calling functions of functions that return "enum fpga_sec_err"
>>>>     to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
>>>> v2:
>>>>   - Reworked the rsu_start_done() function to make it more readable
>>>>   - Reworked while-loop condition/content in rsu_prog_ready()
>>>>   - Minor code cleanup per review comments
>>>>   - Added a comment to the m10bmc_sec_poll_complete() function to
>>>>     explain the context (could take 30+ minutes to complete).
>>>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>>>>   - Moved MAX10 BMC address and function definitions to a separate
>>>>     patch.
>>>> ---
>>>>  drivers/fpga/intel-m10-bmc-sec-update.c | 377 ++++++++++++++++++++++++
>>>>  1 file changed, 377 insertions(+)
>>>>
>>>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> index 6c39adc6492d..a4dc5f47e398 100644
>>>> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> @@ -17,8 +17,14 @@
>>>>  struct m10bmc_sec {
>>>>  	struct device *dev;
>>>>  	struct intel_m10bmc *m10bmc;
>>>> +	struct fw_upload *fwl;
>>>> +	char *fw_name;
>>>> +	u32 fw_name_id;
>>>> +	bool cancel_request;
>>>>  };
>>>>  
>>>> +static DEFINE_XARRAY_ALLOC(fw_upload_xa);
>>>> +
>>>>  /* Root Entry Hash (REH) support */
>>>>  #define REH_SHA256_SIZE		32
>>>>  #define REH_SHA384_SIZE		48
>>>> @@ -179,9 +185,349 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>>>>  	NULL,
>>>>  };
>>>>  
>>>> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>>>> +{
>>>> +	u32 auth_result;
>>>> +
>>>> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
>>>> +
>>>> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
>>>> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
>>>> +}
>>>> +
>>>> +static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
>>>> +{
>>>> +	u32 doorbell;
>>>> +	int ret;
>>>> +
>>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
>>>> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_BUSY;
>>>> +	}
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +static inline bool rsu_start_done(u32 doorbell)
>>>> +{
>>>> +	u32 status, progress;
>>>> +
>>>> +	if (doorbell & DRBL_RSU_REQUEST)
>>>> +		return false;
>>>> +
>>>> +	status = rsu_stat(doorbell);
>>>> +	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
>>>> +		return true;
>>>> +
>>>> +	progress = rsu_prog(doorbell);
>>>> +	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
>>>> +		return true;
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
>>>> +{
>>>> +	u32 doorbell, status;
>>>> +	int ret;
>>>> +
>>>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>>>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
>>>> +				 DRBL_RSU_REQUEST |
>>>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>>>> +					    HOST_STATUS_IDLE));
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>>>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				       doorbell,
>>>> +				       rsu_start_done(doorbell),
>>>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>>>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>>>> +
>>>> +	if (ret == -ETIMEDOUT) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_TIMEOUT;
>>>> +	} else if (ret) {
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	}
>>>> +
>>>> +	status = rsu_stat(doorbell);
>>>> +	if (status == RSU_STAT_WEAROUT) {
>>>> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
>>>> +		return FW_UPLOAD_ERR_WEAROUT;
>>>> +	} else if (status == RSU_STAT_ERASE_FAIL) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>>> +	}
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
>>>> +{
>>>> +	unsigned long poll_timeout;
>>>> +	u32 doorbell, progress;
>>>> +	int ret;
>>>> +
>>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
>>>> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
>>>> +		msleep(RSU_PREP_INTERVAL_MS);
>>>> +		if (time_after(jiffies, poll_timeout))
>>>> +			break;
>>>> +
>>>> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +		if (ret)
>>>> +			return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	}
>>>> +
>>>> +	progress = rsu_prog(doorbell);
>>>> +	if (progress == RSU_PROG_PREPARE) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_TIMEOUT;
>>>> +	} else if (progress != RSU_PROG_READY) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>>> +	}
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
>>>> +{
>>>> +	u32 doorbell;
>>>> +	int ret;
>>>> +
>>>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>>>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				 DRBL_HOST_STATUS,
>>>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>>>> +					    HOST_STATUS_WRITE_DONE));
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>>>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				       doorbell,
>>>> +				       rsu_prog(doorbell) != RSU_PROG_READY,
>>>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>>>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>>>> +
>>>> +	if (ret == -ETIMEDOUT) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_TIMEOUT;
>>>> +	} else if (ret) {
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	}
>>>> +
>>>> +	switch (rsu_stat(doorbell)) {
>>>> +	case RSU_STAT_NORMAL:
>>>> +	case RSU_STAT_NIOS_OK:
>>>> +	case RSU_STAT_USER_OK:
>>>> +	case RSU_STAT_FACTORY_OK:
>>>> +		break;
>>>> +	default:
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>>> +	}
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
>>>> +{
>>>> +	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
>>>> +		return -EIO;
>>>> +
>>>> +	switch (rsu_stat(*doorbell)) {
>>>> +	case RSU_STAT_NORMAL:
>>>> +	case RSU_STAT_NIOS_OK:
>>>> +	case RSU_STAT_USER_OK:
>>>> +	case RSU_STAT_FACTORY_OK:
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	switch (rsu_prog(*doorbell)) {
>>>> +	case RSU_PROG_IDLE:
>>>> +	case RSU_PROG_RSU_DONE:
>>>> +		return 0;
>>>> +	case RSU_PROG_AUTHENTICATING:
>>>> +	case RSU_PROG_COPYING:
>>>> +	case RSU_PROG_UPDATE_CANCEL:
>>>> +	case RSU_PROG_PROGRAM_KEY_HASH:
>>>> +		return -EAGAIN;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +}
>>>> +
>>>> +static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
>>>> +{
>>>> +	u32 doorbell;
>>>> +	int ret;
>>>> +
>>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
>>>> +		return FW_UPLOAD_ERR_BUSY;
>>>> +
>>>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>>>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				 DRBL_HOST_STATUS,
>>>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>>>> +					    HOST_STATUS_ABORT_RSU));
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	return FW_UPLOAD_ERR_CANCELED;
>>>> +}
>>>> +
>>>> +static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
>>>> +					     const u8 *data, u32 size)
>>>> +{
>>>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>>>> +	u32 ret;
>>>> +
>>>> +	sec->cancel_request = false;
>>>> +
>>>> +	if (!size || size & 0x3 || size > M10BMC_STAGING_SIZE)
>>> Why the size should be 4 bytes aligned? I assume this relates to max10
>>> register stride. If so, I suggest we don't use instant number here.
>> This check was not related to stride. All of the image files for these
>> devices are 4-byte aligned. I suppose there is no reason to enforce this
>> as the BMC will detect if a secure image is invalid. I can remove this
>> check.

I'm going to add a check here to make sure that the base address is
aligned.

>>
>>>> +		return FW_UPLOAD_ERR_INVALID_SIZE;
>>>> +
>>>> +	ret = rsu_check_idle(sec);
>>>> +	if (ret != FW_UPLOAD_ERR_NONE)
>>>> +		return ret;
>>>> +
>>>> +	ret = rsu_update_init(sec);
>>>> +	if (ret != FW_UPLOAD_ERR_NONE)
>>>> +		return ret;
>>>> +
>>>> +	ret = rsu_prog_ready(sec);
>>>> +	if (ret != FW_UPLOAD_ERR_NONE)
>>>> +		return ret;
>>>> +
>>>> +	if (sec->cancel_request)
>>>> +		return rsu_cancel(sec);
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +#define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
>>>> +
>>>> +static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data,
>>>> +					   u32 offset, u32 size, u32 *written)
>>>> +{
>>>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>>>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>> reverse xmax tree please.
>> OK - I'll fix it.
>>>> +	u32 blk_size, doorbell;
>>>> +	int ret;
>>>> +
>>>> +	if (sec->cancel_request)
>>>> +		return rsu_cancel(sec);
>>>> +
>>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +	if (ret) {
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>>> +	}
>>>> +
>>>> +	blk_size = min_t(u32, WRITE_BLOCK_SIZE, size);
>>>> +	ret = regmap_bulk_write(sec->m10bmc->regmap,
>>>> +				M10BMC_STAGING_BASE + offset,
>>>> +				(void *)data + offset,
>>>> +				(blk_size + stride - 1) / stride);
>>> You mean to DIV_ROUND_UP the write size here? So you may write more
>>> bytes than required?
>>>
>>> Also possible to access out of bounds for 'data', is it?
>> All of the writes, except possibly the last write, will be of size
>> WRITE_BLOCK_SIZE, which is page aligned. Only the last write could
>> potentially round up on the stride. We have already verified that
>> the data written will fit in the staging area (in the prepare function),
>> so additional bytes to complete the stride will not exceed the staging
>> area which is the target for these writes.
> Is it possible the source memory - 'data' be accessed out of bounds?
Yes, I think it is. I have modified the code to allocate a zero-filled
buffer with size alignment and copy the data in. This should only ever
happen on the last block that is written, since the other writes should
be of size: WRITE_BLOCK_SIZE.

>
>>>> +
>>>> +	if (ret)
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +
>>>> +	*written = blk_size;
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +static enum fw_upload_err m10bmc_sec_poll_complete(struct fw_upload *fwl)
>>>> +{
>>>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>>>> +	unsigned long poll_timeout;
>>>> +	u32 doorbell, result;
>>>> +	int ret;
>>>> +
>>>> +	if (sec->cancel_request)
>>>> +		return rsu_cancel(sec);
>>>> +
>>>> +	result = rsu_send_data(sec);
>>>> +	if (result != FW_UPLOAD_ERR_NONE)
>>>> +		return result;
>>>> +
>>>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
>>>> +	do {
>>>> +		msleep(RSU_COMPLETE_INTERVAL_MS);
>>>> +		ret = rsu_check_complete(sec, &doorbell);
>>>> +	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
>>>> +
>>>> +	if (ret == -EAGAIN) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_TIMEOUT;
>>>> +	} else if (ret == -EIO) {
>>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>>> +	} else if (ret) {
>>>> +		log_error_regs(sec, doorbell);
>>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>>> +	}
>>>> +
>>>> +	return FW_UPLOAD_ERR_NONE;
>>>> +}
>>>> +
>>>> +/*
>>>> + * m10bmc_sec_cancel() may be called asynchronously with an on-going update.
>>>> + * All other functions are called sequentially in a single thread. To avoid
>>>> + * contention on register accesses, m10bmc_sec_cancel() must only update
>>>> + * the cancel_request flag. Other functions will check this flag and handle
>>>> + * the cancel request synchronously.
>>>> + */
>>>> +static void m10bmc_sec_cancel(struct fw_upload *fwl)
>>>> +{
>>>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>>>> +
>>>> +	sec->cancel_request = true;
>>> Do we need some atomic_xx functions to ensure concurrent correctness?
>> In the context of an update, this is once-written and only if the secure update
>> is cancelled. We are only checking true vs false so I don't think atomicity
>> is an issue. Do you recommend that I use atomic_read() and atomic_write() for
> I see the flag is set false on prepare. So if cancel is not allowed in
> prepare phase, there will be no concurrent writing problem.
Cancel is allowed in the prepare phase, but it won't be handled until
the hardware has completed the "prepare" phase. It is being set to
false in prepare, because that is the earliest place in the context
of a new secure update where the flag can be initialized.
> Now there seems a problem that cancel_request is allowed to be set during
> prepare phase, but may be overriden by its initialization to false in
> prepare(). Could we just prevent cancel in prepare phase in framework?
> This is not all about the atomicity for cancel_request but also helps
> solve the concern.
The initialization of the flag is the first thing that happens in
the lower-level driver in the context of a new secure update. Considering
that a user would have to initiate the cancel (CTRL-C or echo 1 > cancel),
I think the window for a race condition is so small that it can be ignored.

If you think this needs to be changed, where would you recommend that
request_cancel be initialized for a new secure-update? I suppose
it could be cleared at the time it is handled, but it seems safer to
explicitly initialize it at the beginning of a new update.

Thanks,
- Russ
>
> Thanks,
> Yilun
>
>> the cancel_request flag?
>>
>>>> +}
>>>> +
>>>> +static void m10bmc_sec_cleanup(struct fw_upload *fwl)
>>>> +{
>>>> +	struct m10bmc_sec *sec = fwl->dd_handle;
>>>> +
>>>> +	(void)rsu_cancel(sec);
>>>> +}
>>>> +
>>>> +static const struct fw_upload_ops m10bmc_ops = {
>>>> +	.prepare = m10bmc_sec_prepare,
>>>> +	.write = m10bmc_sec_write,
>>>> +	.poll_complete = m10bmc_sec_poll_complete,
>>>> +	.cancel = m10bmc_sec_cancel,
>>>> +	.cleanup = m10bmc_sec_cleanup,
>>>> +};
>>>> +
>>>>  #define SEC_UPDATE_LEN_MAX 32
>>>>  static int m10bmc_sec_probe(struct platform_device *pdev)
>>>>  {
>>>> +	char buf[SEC_UPDATE_LEN_MAX];
>>>> +	struct fw_upload *fwl;
>>>> +	unsigned int len, ret;
>>> Why the ret is unsigned int?
>> I will change it to int.
>>
>>>>  	struct m10bmc_sec *sec;
>>>>  
>>>>  	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>>>> @@ -192,6 +538,36 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
>>>>  	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>>>>  	dev_set_drvdata(&pdev->dev, sec);
>>>>  
>>>> +	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
>>>> +		       xa_limit_32b, GFP_KERNEL);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
>>>> +			sec->fw_name_id);
>>>> +	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
>>> Should we check this memory allocation?
>> Yes! - I'll add a check.
>>
>> Thanks for the review.
>> - Russ
>>> Thanks,
>>> Yilun
>>>
>>>> +
>>>> +	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
>>>> +				       &m10bmc_ops, sec);
>>>> +	if (IS_ERR(fwl)) {
>>>> +		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
>>>> +		kfree(sec->fw_name);
>>>> +		xa_erase(&fw_upload_xa, sec->fw_name_id);
>>>> +		return PTR_ERR(fwl);
>>>> +	}
>>>> +
>>>> +	sec->fwl = fwl;
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int m10bmc_sec_remove(struct platform_device *pdev)
>>>> +{
>>>> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
>>>> +
>>>> +	firmware_upload_unregister(sec->fwl);
>>>> +	kfree(sec->fw_name);
>>>> +	xa_erase(&fw_upload_xa, sec->fw_name_id);
>>>> +
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -205,6 +581,7 @@ MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
>>>>  
>>>>  static struct platform_driver intel_m10bmc_sec_driver = {
>>>>  	.probe = m10bmc_sec_probe,
>>>> +	.remove = m10bmc_sec_remove,
>>>>  	.driver = {
>>>>  		.name = "intel-m10bmc-sec-update",
>>>>  		.dev_groups = m10bmc_sec_attr_groups,
>>>> -- 
>>>> 2.25.1

