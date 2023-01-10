Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D8D663E4F
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Jan 2023 11:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjAJKch (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Jan 2023 05:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjAJKcX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 Jan 2023 05:32:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76594086E;
        Tue, 10 Jan 2023 02:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673346741; x=1704882741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9/kJ2xAAlDxaM8+ITKEhkvbhwMba0eMpEUpzikqaENM=;
  b=N7Szr+QIQlZc/N+GIDc3aEzK3bWtm1U7dBj60yxo/SVACW3xnnL26ZGf
   5KOVxLMeyl7z3JU2OSxvMx4AOz/p7UXnWdc4LnAWNdtFzcUKNt8tkiF2S
   dULsiirsNyZPGFcggWL/VKZF4w6DIxO2lXrUtggtt0PF9oqjxqKJVKRMh
   +tLDJ3OfixWOxxkNuDubXaX5fmsot7vWmbsUQPOem0Pft6ZCbaDZ/0zig
   mDaQS3JCrGqskrmwjOJg5wxyoCLiP50Kfl+B508PAyUninojxY5lkERx9
   S/t08ncGI/TuWfiak9VyPm+s6dZII3QkchF+JostfpXQ96C7484yVbXuv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="387566158"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="387566158"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 02:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902322641"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="902322641"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2023 02:32:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFBvQ-006zAK-2s;
        Tue, 10 Jan 2023 12:32:12 +0200
Date:   Tue, 10 Jan 2023 12:32:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v10 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Message-ID: <Y70+rAq1QoS4ohdG@smile.fi.intel.com>
References: <20230110003029.806022-1-matthew.gerlach@linux.intel.com>
 <20230110003029.806022-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110003029.806022-5-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 09, 2023 at 04:30:29PM -0800, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.

...

> +static int dfh_get_u64_param_val(struct dfl_device *dfl_dev, int param_id, u64 *pval)
> +{
> +	size_t psize;
> +	u64 *p;
> +
> +	p = dfh_find_param(dfl_dev, param_id, &psize);
> +	if (IS_ERR(p))
> +		return PTR_ERR(p);

> +	if (psize != sizeof(u64))
> +		return -EINVAL;

If this code stays in the newer versions, make it more robust against changes,
i.e. by using sizeof(*pval).

> +	*pval = *p;
> +
> +	return 0;
> +}

...

> +config SERIAL_8250_DFL
> +	tristate "DFL bus driver for Altera 16550 UART"

5

> +	depends on SERIAL_8250 && FPGA_DFL
> +	help
> +	  This option enables support for a Device Feature List (DFL) bus
> +	  driver for the Altera 16650 UART. One or more Altera 16650 UARTs

6

Which one is correct?

> +	  can be instantiated in a FPGA and then be discovered during
> +	  enumeration of the DFL bus.
> +
> +	  To compile this driver as a module, chose M here: the
> +	  module will be called 8250_dfl.

-- 
With Best Regards,
Andy Shevchenko


