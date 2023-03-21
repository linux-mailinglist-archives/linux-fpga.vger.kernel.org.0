Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6CC6C35D1
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Mar 2023 16:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjCUPft (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Mar 2023 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjCUPfr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Mar 2023 11:35:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98153193DB;
        Tue, 21 Mar 2023 08:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+tW3AdcjQLtWeip8u/u1zPXkDAtOmPVD4dM9WuFOlqdmLkz2363cBRa26o6K+xgT5/yr2gm5U+Zoh6EgbyCQ78nyfL3OjCMVzCewA6irWkNV2k01XNasNkpmHWrDjlbnEmDfga81StEvcZd5Z5yDkf1XR3tYpiSAaXBavfvpSA0t4BEYLqDbKxO6986Vsovr5BlBqKbetiQ0up65ICPdiul3i4JkQUcxDdF3vqQCk7OYRPcJLUpsLIGNdzwcMGk53A5ad8T65LO5DN1TEkeHH17bt3av9wfhgQ5dA+Hm4YQ0VGNKazVCFM/wD9PP2xEfTkahBxCojwNFJLy2+ZxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkwt7n76p+MAy/XMtlEvMzJ2m87XZvtLHHDjGUQUSyM=;
 b=dX0Gz6OPxU7p6iH4C2TVfspBAy0OhodrnOowpwi2Z5ruQLYScilW+hEWgayU40YCuxVvzciJ+cntixqGJfPqq+LD1bTFEPeL0sFMGYH/Il3EApURSlEvu1jkVLsOj8KI4MZo/xWEXNzyYFGmBkRKlg08Ah5rM+0PDc2/tWve8aphdKWYz+9OJWvCFB4f/TEnM9Xy+yAOViVryfBuqNh7hIZ3sAQJsoYltserXDJRm+hk6BIt1WkXxwYZDR5pxFD4tW9EoDspnuTw7Zuzfyx180XvsgmrHHJS3ipjj6OPp/tsK6vFo5U2peVkhUawDAJDunc4rO/nLfLHu/Y6wi8VTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkwt7n76p+MAy/XMtlEvMzJ2m87XZvtLHHDjGUQUSyM=;
 b=l2ucIKwxMy/FP8w8GTAn2A2mp1c8PmlQLqCOM+R/8VdjApYlF07AZZy/dlOmXKgvlEIyq3LngHFJo3tFG871r2JUd/WOn1qmuQafmoSI5WUfp4Nd6mNyDJZwU6+TTa5V2+DqRhZr6Sy3eUt96sMzNwUSWCaNuTYi7UZFKcHLiWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:35:43 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 15:35:43 +0000
Message-ID: <94930302-571a-6712-c1a2-109a04ced418@amd.com>
Date:   Tue, 21 Mar 2023 16:35:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230317230617.1673923-1-trix@redhat.com>
 <c8eaefed-e1fd-e0c1-7e8f-561c20632646@amd.com>
 <ZBhqutJChvRkUsRL@yilunxu-OptiPlex-7050>
 <2dc1f25d-d621-ec04-6de5-f731f2a8bb41@redhat.com>
 <5fb2fa11-5a58-1856-7cb9-9687637d0741@redhat.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: remove unused
 xlnx_pr_decouple_read function
In-Reply-To: <5fb2fa11-5a58-1856-7cb9-9687637d0741@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0602CA0012.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::22) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5066c9-9f0b-4943-cbd8-08db2a21ee93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fbb8TPZ4MpU+6szqzyymVnR2Iv+25o/eiJAyUEzUZm2gzKXUoYUdtLxN1nhQ6qSHfYT9doyW3K/39WX7CmFKF1NZpK0xK2On8v5sDp+Hd8B6w327xdEsznkq/alferi4Voa6k5cu/V7n2VNp+bBQhsh2DS59M1qHj6HugenEZwW/ObCcra6bOTzeVzFA3OLz+C5GtGChF8RSLGucjvlYwbCQSlNkEdy7dCi9K56aIxbmCLCYpJBouah9ZnS1nxZRBq18C5RVS4i6swDnkZF+U5ZF8EAfvTU/W3IBpoAq8B3FOWv2TxHI3YLnS73zaNimTgQ+TommF0G7Djnvp7KR+bc8EZ0vTRV9g2H/GYylRF4rH72KWC3ev5AdiuX0nmj7+TdbeWXRXjEv18QCdRv6vfe9qegLDgvmNATeu77yNSfRSD8dhojR6E4kIXDSo+bkYhckSmB2PxznSjO/5Q6G5L1Y48E0obkwWYd6H72Kr6j3YlcIku6vza8VCpcj79zLqVcsfC6XRgkCwaU08/Ih9OR/NaSqV2Y2UnFbnOFXGdQrO/62DyLDGWH65ryJ/CY/7T0Fx08a61LEw/CtIc8F5AXHddWqF1ZLhfnrtLk9OLl3GqUulqXqTa8pZri7kkw1/Q7Iwv61MQjg3f3al8YAlY4owXK3dkRUcsTahxlG1gYmjuvy/5I+J6haAbFMCvkPJk+d6X2JzGiTmdhGmspTzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199018)(8936002)(41300700001)(7416002)(5660300002)(44832011)(31696002)(36756003)(86362001)(38100700002)(4326008)(2906002)(83380400001)(6506007)(31686004)(53546011)(6512007)(478600001)(6666004)(186003)(26005)(6486002)(966005)(8676002)(66476007)(66556008)(66946007)(2616005)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJ2NUtKSEJMTTNjdm45ZFk2UWtETUVGSkd4cGp1bi84cDg3cmxVRU42alYw?=
 =?utf-8?B?VnpmL2dIc0dQclVPdHgwcmgyL3pqVXRtejgwNGQvd24zeE92T0cyT05oVzhm?=
 =?utf-8?B?N013cnN0RXVPZXMzV2FHbFBPSS90OTNyVDJlWStuZ09HVEpxbVRiUjdHUjFx?=
 =?utf-8?B?aWNPeUtteGhnb2cvMmk0Z293R29ha1dqM0FhUUcwa2RxREl2QmZldm9Hemx4?=
 =?utf-8?B?WGNKWThRN3RURVlVYWZ4cm8xQmptOThNNWt4RWxGTWtHRHNLanZoNGViWGVT?=
 =?utf-8?B?RWVMNGVWcVhRTE1Mek9lOUNUSnJ2cEJqd1N2NUhmNHc1T0R6MTVtUDBuWFBz?=
 =?utf-8?B?NWY5V3FYTUJGaWhoWVBsYkkrYlNtbHVhV09GT2NPYytDSmo0dmVkeDFra3pW?=
 =?utf-8?B?NGFxaDJUdzdVblhSMDIwcTlyVUU3OUxTenBhazVvcC9KVlYzcHlNNzZZNFpo?=
 =?utf-8?B?em1CaDkzVTFWbmJqbnRvUW5xYnBNbFlhc3VwMjcwekFDRWlzZ3JkR3ZwU2pi?=
 =?utf-8?B?c2Voa3cxWHJNL1JhUGlXZnRWNHpPOHMwM1AvQStYcWlmTUtkYU5uK2h1eGVV?=
 =?utf-8?B?T0gzY1ZzQjRmeUVRd3pjQWxYbzQrM1V5czB0c1lKMkU1NXp0UkEyOVZya1Y5?=
 =?utf-8?B?VDZEdzJEbUFMbVArSXVxUFFwT0pybW52L2l4MStZYTFHajZaNjZCRlZoTk5C?=
 =?utf-8?B?NFZyaSsyV3p5U1RVS25WQmV0Vy9KUVNmcDk1c05CbkZwa0ZwWVBlYmZiM0tw?=
 =?utf-8?B?cWxGRy9IWWRTUkVrc0VwdHpuOERWRktzbStjTGpDVm83Y2FPYUt6U0xPMlNY?=
 =?utf-8?B?cU5qSzlNWVVGbFdBcHd2c2FQamFkYWUzMTlKUFlmNWJFZ082Skwvd01pL0xi?=
 =?utf-8?B?SGJuNkFHeGNhUUhiSGV2YjN1YVV4SDBxUlZqUCt4TUt0NDF2UWY5cWRYZGh0?=
 =?utf-8?B?YlRhc2xpTy9PeFkyUEdMZ0w4U21Sdmp6SlY1QnNubnROeE1zQTJUMWlHdUdY?=
 =?utf-8?B?d3dpV3lkSExIR3oydjd4NmhTWWpMMVFEcXJUTncwNitnVmgzZXBSZTdzaWI4?=
 =?utf-8?B?cGQyNFVVWC9ibGpmdmk3TDhlL3VlMHJjZWlqRDlDZ3ZyVzB2anRqbXlpVUFS?=
 =?utf-8?B?TkZrVE1zMkNTQW9heVZEWG1Zck1BU3NTZlRVZnQ0SDhEQVFJcXQwb2I1Vm9Q?=
 =?utf-8?B?cWNUZ2doNjRUZHFmdGZFRWk1RmZkTnYybEl1Z052aHBnUTV0ZCt0eEFZS1M0?=
 =?utf-8?B?ZUM3VEdTcTNmV0JVanM1Zm1DcVRsNjlVL0hicTNDTFp5bVJKbEhjRmN4b0NV?=
 =?utf-8?B?TVdZSmdFUnBkUGdOLy9RcW94YUdJclYwQ0VWZzBSMlBLZWRjRmROTk9tT2hw?=
 =?utf-8?B?aEtFYW1NN1VVamtoZW16bDdGTlhLZnZ1OWs1Qk16dlk1RGdERU95RktjSDBD?=
 =?utf-8?B?eDFuc001RFdPdjlTS2RXV1NRMkJjVGJwd0trVXVic01XMzJUMGR3QllWSHRr?=
 =?utf-8?B?MkZaMlhPYlZvWDRXWEUzM3JTRHRKbFlTQmxPSTBZRXN5QXNCWlo5MkpOWWJF?=
 =?utf-8?B?UjZCZThaQ2tEaTFUMG9DNld5NUMrVTE5Z3grWGw4a1BVRDFnampVRnFFbm52?=
 =?utf-8?B?NWJ3MkJmVmp4OHFWSmsrbGhWejQyZUI2RmVLcmQ1VDhMZVlHWHpNNWY5aFVQ?=
 =?utf-8?B?bWhPMktNZnFMR0pmMng0WnVEZWlMb21COEtOdVZnaStXc0tudzVOVXpkTmtC?=
 =?utf-8?B?L3M3d25oOENFSktuZG1LTDBFY2YzekdOOTNhcTUrYlpmMGNRcDBQS3pwUExK?=
 =?utf-8?B?dWtnYk53eTN2NGFvamo2eE9MZEdjOHN0ekRxeEx5QjhlZnVVTVVuQld1aS91?=
 =?utf-8?B?Q2FFTWJZN1lvTStLa1RCMHVEYWRYV3lycWYwNUV2dEk0UUttbnVER1dOYi9h?=
 =?utf-8?B?Tlp4dlR0TjFnSXcxOEkzMFJYY0w4bEpFWWZTUUxrak9aU2xOVGJFYXZueFFZ?=
 =?utf-8?B?Y01YOUJOTEpCNDd6dXZuK3IwOTJ2U2QvajRoNFU1c29FNGl0VnZvdW1HWWN0?=
 =?utf-8?B?Q1VCazZNQ3p1UGszdzkvL1A3djU5Y09rK1ppbzlmcnMwSXlCdXZkbDEyRERJ?=
 =?utf-8?Q?sjtrhswdf9GGTjzHL4iTmRjgo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5066c9-9f0b-4943-cbd8-08db2a21ee93
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 15:35:43.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK/4hNXn7R31E7Xu9TiEtP/jkAQnY/bqx9R+YHrBsH0sa62Jb2yUxu944ZdZaSMX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 3/20/23 21:05, Tom Rix wrote:
> 
> On 3/20/23 9:24 AM, Tom Rix wrote:
>>
>> On 3/20/23 7:16 AM, Xu Yilun wrote:
>>> On 2023-03-20 at 08:40:22 +0100, Michal Simek wrote:
>>>>
>>>> On 3/18/23 00:06, Tom Rix wrote:
>>>>> CAUTION: This message has originated from an External Source. Please use 
>>>>> proper judgment and caution when opening attachments, clicking links, or 
>>>>> responding to this email.
>>>>>
>>>>>
>>>>> clang with W=1 reports
>>>>> drivers/fpga/xilinx-pr-decoupler.c:37:19: error: unused function 
>>>>> 'xlnx_pr_decouple_read' [-Werror,-Wunused-function]
>>>>> static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data 
>>>>> *d,
>>>>>                     ^
>>>>> This static function is not used, so remove it.
>>>>>
>>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>>> ---
>>>>>    drivers/fpga/xilinx-pr-decoupler.c | 6 ------
>>>>>    1 file changed, 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/fpga/xilinx-pr-decoupler.c 
>>>>> b/drivers/fpga/xilinx-pr-decoupler.c
>>>>> index 2d9c491f7be9..b6f18c07c752 100644
>>>>> --- a/drivers/fpga/xilinx-pr-decoupler.c
>>>>> +++ b/drivers/fpga/xilinx-pr-decoupler.c
>>>>> @@ -34,12 +34,6 @@ static inline void xlnx_pr_decoupler_write(struct 
>>>>> xlnx_pr_decoupler_data *d,
>>>>>           writel(val, d->io_base + offset);
>>>>>    }
>>>>>
>>>>> -static inline u32 xlnx_pr_decouple_read(const struct 
>>>>> xlnx_pr_decoupler_data *d,
>>>>> -                                       u32 offset)
>>>>> -{
>>>>> -       return readl(d->io_base + offset);
>>>>> -}
>>>>> -
>>>>>    static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool 
>>>>> enable)
>>>>>    {
>>>>>           int err;
>>>>> -- 
>>>>> 2.27.0
>>>>>
>>>> It should be fixed like this instead.
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>> diff --git a/drivers/fpga/xilinx-pr-decoupler.c 
>>>> b/drivers/fpga/xilinx-pr-decoupler.c
>>>> index 2d9c491f7be9..58508f44cd49 100644
>>>> --- a/drivers/fpga/xilinx-pr-decoupler.c
>>>> +++ b/drivers/fpga/xilinx-pr-decoupler.c
>>>> @@ -69,7 +69,7 @@ static int xlnx_pr_decoupler_enable_show(struct
>>>> fpga_bridge *bridge)
>>>>          if (err)
>>>>                  return err;
>>>>
>>>> -       status = readl(priv->io_base);
>>>> +       status = xlnx_pr_decouple_read(priv);
>>> OK, I'll drop the previous fix, and waiting for the new one.
>>
>> Michal,
>>
>> Will you make this change ?
> 
> Let me provide some context.
> 
> I am cleaning up about 70 similar unused functions all over the tree.
> 
> I have removed a lot of one liner wrappers that look like this.
> 
> My opinion, to be useful the wrapper needs to be used multiple places and/or do 
> something non trival otherwise we will bloat the codebase with with 5x lines of 
> code to do a simple readl.
> 
> But this is subjection. If you want this change, you should make it.

I understand your position. From my perspective when drivers use these wrappers 
around io functions they are pretty much prepared to be easily extended for 
other access method. And also it helps with debugging.

I sent the patch here.
https://lore.kernel.org/r/0381e4e8061c2fee182a104768e84feff3a82d25.1679412800.git.michal.simek@amd.com

Thanks,
Michal

