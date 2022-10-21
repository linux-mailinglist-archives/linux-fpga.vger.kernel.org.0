Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2CC607403
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Oct 2022 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJUJYy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 21 Oct 2022 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJUJYw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 21 Oct 2022 05:24:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DED6275EC;
        Fri, 21 Oct 2022 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666344286; x=1697880286;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jk3GGigshY3ozVIft32XqiGGnJhMw0o6601+Pv/jJHg=;
  b=mj1BFCVKcskK+BTfao7mXFCM9rgaGB99p6F9MPEms9aSw8UGe/dMMotu
   d/Q/Q5A9ekMHBlXiEbsDpjT5fgVL51BxL/9Ll8DB0OkAv5AOS2X+DsPuu
   kMdg65GHe9C96LoKwEo+qL9XLlbUrSLriE5KkBZtjO+LWCa7/VHhOA/wC
   e6J3Q7JxYQIsHZsVYQ0hI8X9xI6jffmUM6dkPx5adcr+jrPkQ+OnHZ7ld
   S8v6Nv0/ZOH7QegCL/lv6y1uPKt0JB/IS15z2e0HvIIucVAXN9fbJ63+r
   ys5O7vOcztCtUydvIcXI2KU7HSQ07CXI+e0Tkr9QF+V8Z3U5vSiNpOfnv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="304572661"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="304572661"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:24:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719621315"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="719621315"
Received: from lramir2-mobl1.ger.corp.intel.com ([10.252.44.179])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:24:38 -0700
Date:   Fri, 21 Oct 2022 12:24:35 +0300 (EEST)
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
Subject: Re: [PATCH v4 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <20221020212610.697729-5-matthew.gerlach@linux.intel.com>
Message-ID: <37342f3-cac7-e127-5bea-27b78dbc31c@linux.intel.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 20 Oct 2022, matthew.gerlach@linux.intel.com wrote:

> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---

> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_REG_LAYOUT);
> +	if (!p)
> +		return dev_err_probe(dev, -EINVAL, "missing REG_LAYOUT param\n");
> +
> +	v = *p;
> +	uart->port.regshift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
> +	reg_width = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);

Just use *p directly for the FIELD_GETs. I suppose you can drop v after 
changing it.

Other than that and what Andy noted, this patch looks good.


-- 
 i.

