Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E1F607386
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Oct 2022 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiJUJID (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 21 Oct 2022 05:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiJUJIB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 21 Oct 2022 05:08:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F361C3E55;
        Fri, 21 Oct 2022 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666343280; x=1697879280;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f186kABHfz6j3m5TTCFTlEj9tjvEmDT5jsf2cCWJk5E=;
  b=I+skOc/zPUr0103odIwwnD/MqFdEr53nXqTHp6Ee5LINhA0y14Jtl+6G
   j58Ub3A9sxpCCCHwqxpv8s/5CK2gukzUPCZfH+qSW1NHXnn9Jhdb8OJTb
   ifJYJDgQaiAq3W7qPn289Cp/2z6zQv8N4qKpxfHzWl6kx1ZbHDj71n85w
   yQyC7M1YrM/Izqy5jXaUOLbc07RuAHqoU7uxmJabA8xUXUqXkBY/x/NW9
   dcj96Yaq6R7kRmaPYri4p42XM8ebz3a+plMWbe6UFyaiNZp8vU/Vx+RXk
   psbUFuOBRELmGxFJut2NPEI23f1XQ/TuJHd8ZSZgxAN47Wej2DHmLivxI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="290263327"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="290263327"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:08:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="805459735"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="805459735"
Received: from lramir2-mobl1.ger.corp.intel.com ([10.252.44.179])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:07:54 -0700
Date:   Fri, 21 Oct 2022 12:07:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, Lukas Wunner <lukas@wunner.de>,
        marpagan@redhat.com
Subject: Re: [PATCH v4 3/4] fpga: dfl: add basic support DFHv1
In-Reply-To: <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
Message-ID: <4d44fdd5-8c7a-622-25e2-4ce2cc9698dd@linux.intel.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 20 Oct 2022, matthew.gerlach@linux.intel.com wrote:

> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add generic support for MSI-X interrupts for DFL devices.
> 
> The location of a feature's registers is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address.  Parse the location and pass the information
> to DFL driver.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---

> @@ -934,56 +962,108 @@ static u16 feature_id(u64 value)
>  	return 0;
>  }
>  
> +static void *find_param(void *base, resource_size_t max, int param)
> +{
> +	int off = 0;
> +	u64 v, next;
> +
> +	while (off < max) {
> +		v = *(u64 *)(base + off);
> +		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
> +			return base + off + DFHv1_PARAM_DATA;
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		off += next & ~DFHv1_PARAM_HDR_NEXT_MASK;
> +		if (next & DFHv1_PARAM_HDR_NEXT_EOL)
> +			break;
> +
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * dfh_find_param() - find data for the given parameter id
> + * @dfl_dev: dfl device
> + * @param: id of dfl parameter
> + *
> + * Return: pointer to parameter data on success, NULL otherwise.
> + */
> +void *dfh_find_param(struct dfl_device *dfl_dev, int param)
> +{
> +	return find_param(dfl_dev->params, dfl_dev->param_size, param);
> +}
> +EXPORT_SYMBOL_GPL(dfh_find_param);

Do you expect this split between dfh_find_param() and find_param() to
be useful in the future? If no other callers are expected, I'd just pull 
find_param() into dfh_find_param() and create local variables for base and 
max.

-- 
 i.

