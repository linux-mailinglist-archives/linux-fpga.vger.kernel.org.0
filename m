Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19D661EE2
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Jan 2023 07:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjAIGzF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Jan 2023 01:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjAIGzB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Jan 2023 01:55:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8969E1275B;
        Sun,  8 Jan 2023 22:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673247299; x=1704783299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h14Ky+gxZkW2WnGWN9E+VGFINdCzmMuf5XUAHnYvEro=;
  b=GnU4WhmCVCAIUKxylujt/9qepmSppyZX756eF7tK+zg2kVo784y9E2YT
   nUSgyMnUll1FW/4MsKJs7rliOI0ys9U1Gh33dTTG+t5nWVomKF/QweWOY
   cgGMqTFGubnZDd3/l0bVirAKi6aMFBNrS+gws8CKMTc1jqkYR+WZBiu3P
   g9a1xoEJqy2JiR4MtZU1zBq1oWTW5OlElvTRUUeYadLYWWyYCNs25U6se
   XEpzi/1WxjNt0YzoBrtMXTj4u3zFglKnacF9kYZTGdGkChEJZQWBOFLsc
   7LNX7ipBMhBzAO3nLo+7F/JywQmCR2/I2nYoIpbDg9SsdiTPlyUav2jht
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="321509833"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="321509833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 22:54:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="798914008"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="798914008"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jan 2023 22:54:53 -0800
Date:   Mon, 9 Jan 2023 14:44:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, russell.h.weight@intel.com,
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
Message-ID: <Y7u31S8aba1L+VeA@yilunxu-OptiPlex-7050>
References: <20230104232253.24743-1-matthew.gerlach@linux.intel.com>
 <20230104232253.24743-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104232253.24743-4-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-04 at 15:22:52 -0800, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Version 1 of the Device Feature Header (DFH) definition adds
> functionality to the Device Feature List (DFL) bus.
> 
> A DFHv1 header may have one or more parameter blocks that
> further describes the HW to SW. Add support to the DFL bus
> to parse the MSI-X parameter.
> 
> The location of a feature's register set is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address. Parse the location and pass the information
> to DFL driver.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>

[...]
  
> +static u64 *find_param(u64 *params, resource_size_t max, int param_id)
> +{
> +	u64 *end = params + max / sizeof(u64);
> +	u64 v, next;
> +
> +	while (params < end) {
> +		v = *params;
> +		if (param_id == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
> +			return params;
> +
> +		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
> +			break;
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		params += next;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * dfh_find_param() - find parameter block for the given parameter id
> + * @dfl_dev: dfl device
> + * @param_id: id of dfl parameter
> + * @pcount: destination to store size of parameter data in u64 bit words

As I mentioned before, could the size of the parameter data just be number
of bytes? This is the most common way for a data block.

Thanks,
Yilun

> + *
> + * Return: pointer to start of parameter data, PTR_ERR otherwise.
> + */
> +void *dfh_find_param(struct dfl_device *dfl_dev, int param_id, size_t *pcount)
> +{
> +	u64 *phdr = find_param(dfl_dev->params, dfl_dev->param_size, param_id);
> +
> +	if (!phdr)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (pcount)
> +		*pcount = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, *phdr) - 1;
> +
> +	return phdr + 1;
> +}
> +EXPORT_SYMBOL_GPL(dfh_find_param);
