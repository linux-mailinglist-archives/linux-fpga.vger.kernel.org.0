Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2DE662E20
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Jan 2023 19:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbjAISFb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Jan 2023 13:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbjAISEu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Jan 2023 13:04:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF4A43E64;
        Mon,  9 Jan 2023 10:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673287451; x=1704823451;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yGPCCnwR0gm5/eGURTOcLZCYZz5bk0RgAbSzmUX9Ns8=;
  b=cVwpJ8mBtyoLk82bjToU/p5W0H5TUBnQzneQkb9mxWFZS37FBr5FKn7m
   47Vav6FbUO0DfaxyGO04Cpv6lyElEOgMHui1f0wn4AiOj7Szoh3QBoPQc
   3YZwUismwjXtBooTpiBKKTgrp5nvt45w1QdZXsd4ax1bGEmXQWAbavcMA
   AEAUsXRIO8AEbfRU+jpjXzqIweWfBJmvX/JecRG+nMkLit07wld3N5zU8
   AqlBIkDBJ6Co1pilbS6V2qn4dBDquUwedzOETPsg2tgXnoXvzx18EXIXS
   EOrQjwUXCz6IRPhVnKnPghIknXGWFPRk/4E98AjgRjWhW8shg7Le5w9j5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="323016827"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="323016827"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 10:04:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="745452384"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="745452384"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 10:04:09 -0800
Date:   Mon, 9 Jan 2023 10:04:32 -0800 (PST)
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
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v9 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <Y7u31S8aba1L+VeA@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2301091003330.801533@rhweight-WRK1>
References: <20230104232253.24743-1-matthew.gerlach@linux.intel.com> <20230104232253.24743-4-matthew.gerlach@linux.intel.com> <Y7u31S8aba1L+VeA@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1694820295-1673287487=:801533"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1694820295-1673287487=:801533
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT



On Mon, 9 Jan 2023, Xu Yilun wrote:

> On 2023-01-04 at 15:22:52 -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Version 1 of the Device Feature Header (DFH) definition adds
>> functionality to the Device Feature List (DFL) bus.
>>
>> A DFHv1 header may have one or more parameter blocks that
>> further describes the HW to SW. Add support to the DFL bus
>> to parse the MSI-X parameter.
>>
>> The location of a feature's register set is explicitly
>> described in DFHv1 and can be relative to the base of the DFHv1
>> or an absolute address. Parse the location and pass the information
>> to DFL driver.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>
> [...]
>
>> +static u64 *find_param(u64 *params, resource_size_t max, int param_id)
>> +{
>> +	u64 *end = params + max / sizeof(u64);
>> +	u64 v, next;
>> +
>> +	while (params < end) {
>> +		v = *params;
>> +		if (param_id == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
>> +			return params;
>> +
>> +		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
>> +			break;
>> +
>> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
>> +		params += next;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * dfh_find_param() - find parameter block for the given parameter id
>> + * @dfl_dev: dfl device
>> + * @param_id: id of dfl parameter
>> + * @pcount: destination to store size of parameter data in u64 bit words
>
> As I mentioned before, could the size of the parameter data just be number
> of bytes? This is the most common way for a data block.

returning a void* and a size_t in bytes would be more consistent.  I will 
make your suggested change.

Thanks,
Matthew Gerlach

>
> Thanks,
> Yilun
>
>> + *
>> + * Return: pointer to start of parameter data, PTR_ERR otherwise.
>> + */
>> +void *dfh_find_param(struct dfl_device *dfl_dev, int param_id, size_t *pcount)
>> +{
>> +	u64 *phdr = find_param(dfl_dev->params, dfl_dev->param_size, param_id);
>> +
>> +	if (!phdr)
>> +		return ERR_PTR(-ENOENT);
>> +
>> +	if (pcount)
>> +		*pcount = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, *phdr) - 1;
>> +
>> +	return phdr + 1;
>> +}
>> +EXPORT_SYMBOL_GPL(dfh_find_param);
>
--8323328-1694820295-1673287487=:801533--
