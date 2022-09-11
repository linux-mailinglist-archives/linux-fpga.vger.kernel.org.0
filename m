Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2029B5B5006
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIKQVf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIKQVZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 12:21:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C2B13F02;
        Sun, 11 Sep 2022 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662913284; x=1694449284;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=afnYNxBE1faQLt1ou19ySq2DFzzNl3lg+B6mfO4Ehng=;
  b=NuPQxWZLnT6i1yh6CwiQ24t4Raa6thhKhudE9mYMm07fT+E3ehNC8h7W
   736s2D/A1bUpWod93pKzQ3Ay4rffvDhEe/qotpRrX0uYgu4GvUnxUn+gG
   nE+PTf1K2rR1iKsUfDntFfJSdzhI820Uk63hRE7JAYEh0mnNpCrfX/ZEJ
   yNcD01Zv4asQDnso/G4mY4CFPHuZQQB0Oj0pT7FgEOZAM+Dbx0x+3QpYf
   gKO+09/Kfw9jwcnDAKzztYky246A/Kz7BXTzn9Qfhhh7nNp0JnF2RdToj
   cTCHRzqFcrUBRrp0YmQA4MPX3wG35BL2h847qF0rDom1z3tPmb6zYA9oD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="359459860"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="359459860"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 09:21:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="944358817"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 09:21:23 -0700
Date:   Sun, 11 Sep 2022 09:21:42 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Xu Yilun <yilun.xu@intel.com>
cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v1 3/5] fpga: dfl: Add DFHv1 Register Definitions
In-Reply-To: <Yx2cAaQ0HhPkYyC4@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2209110920490.142336@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-4-matthew.gerlach@linux.intel.com> <Yx2cAaQ0HhPkYyC4@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Sun, 11 Sep 2022, Xu Yilun wrote:

> On 2022-09-06 at 12:04:24 -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
>>
>> This patch adds the definitions for DFHv1 header and related register
>> bitfields.
>>
>> Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  include/linux/dfl.h | 37 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>
>> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
>> index b5accdcfa368..61bcf20c1bc8 100644
>> --- a/include/linux/dfl.h
>> +++ b/include/linux/dfl.h
>> @@ -23,6 +23,16 @@
>>  #define GUID_H			0x10
>>  #define NEXT_AFU		0x18
>>
>> +/*
>> + * DFHv1 Register Offset definitons
>> + * In DHFv1, DFH + GUID + CSR_START + CSR_SIZE_GROUP + PARAM_HDR + PARAM_DATA
>> + * as common header registers
>> + */
>> +#define DFHv1_CSR_ADDR		0x18  /* CSR Register start address */
>> +#define DFHv1_CSR_SIZE_GRP	0x20  /* Size of Reg Block and Group/tag */
>> +#define DFHv1_PARAM_HDR		0x28  /* Optional First Param header */
>> +#define DFHv1_PARAM_DATA	0x8   /* Offset of Param data from Param header */
>> +
>>  #define DFH_SIZE		0x8
>>
>>  /* Device Feature Header Register Bitfield */
>> @@ -30,8 +40,35 @@
>>  #define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
>>  #define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
>>  #define DFH_EOL			BIT_ULL(40)		/* End of list */
>> +#define DFH_VERSION		GENMASK_ULL(59, 52)	/* DFH version */
>>  #define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
>>
>> +/*
>> + *  CSR Rel Bit, 1'b0 = relative (offset from feature DFH start),
>
> Reduce one whitespace indent.
>
>> + * 1'b1 = absolute (ARM or other non-PCIe use)
>> + */
>> +#define DFHv1_CSR_ADDR_REL	BIT_ULL(0)
>> +
>> +/*
>> + * CSR Header Register Bit Definitions
>> + */
>
> Use oneline style comment should be OK?
>
>> +#define DFHv1_CSR_ADDR_MASK       GENMASK_ULL(63, 1)  /* 63:1 of CSR address */
>> +
>> +/*
>> + * CSR SIZE Goup Register Bit Definitions
>> + */
>
> Same concern
>
>> +#define DFHv1_CSR_SIZE_GRP_INSTANCE_ID	GENMASK_ULL(15, 0)	/* Enumeration instantiated IP */
>> +#define DFHv1_CSR_SIZE_GRP_GROUPING_ID	GENMASK_ULL(30, 16)	/* Group Features/interfaces */
>> +#define DFHv1_CSR_SIZE_GRP_HAS_PARAMS	BIT_ULL(31)		/* Presence of Parameters */
>> +#define DFHv1_CSR_SIZE_GRP_SIZE		GENMASK_ULL(63, 32)	/* Size of CSR Block in bytes */
>> +
>> +/*
>> + * PARAM Header Register Bit Definitions
>> + */
>
> Same
>
>> +#define DFHv1_PARAM_HDR_ID		GENMASK_ULL(15, 0) /* Id of this Param  */
>> +#define DFHv1_PARAM_HDR_VERSION		GENMASK_ULL(31, 16) /* Version Param */
>> +#define DFHv1_PARAM_HDR_NEXT_OFFSET	GENMASK_ULL(63, 32) /* Offset of next Param */
>> +
>>  /**
>>   * enum dfl_id_type - define the DFL FIU types
>>   */
>> --
>> 2.25.1
>>
>

Hi Yilun,

I will fix the extra whitespace and change the comments to a single line 
where appropropriate.

Thanks,
Matthew Gerlach
