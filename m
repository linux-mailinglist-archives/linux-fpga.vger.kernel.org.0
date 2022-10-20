Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB4606B18
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Oct 2022 00:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJTWNj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Oct 2022 18:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJTWNi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Oct 2022 18:13:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A07F1DDDE6;
        Thu, 20 Oct 2022 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666304017; x=1697840017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aw6d6bWnln28MF2jEzl2niRBEvZWaM/GCIo3nTnrPNY=;
  b=Tx36d1QjZhmx98RE8JZAk6PzEJBsBNFL+XMHuGOQ/fevJEXflb7MQO4d
   42Ht0DrMK0yLHylsNAAntdlt3c6vYqm1ehyA79INSmGRUr/FA1scXGPiW
   8tPJrgBFHsKFx13YdFgwUYQkS3dljLUms/BS5+zw5Kk4cWMigSh48RzDJ
   GN74ztkcJdH+ViOhQk335TIaC034j8yyY69yhf5bibmp0ZWHhI0STVj6H
   cYl/jZJ4BLj/Ofa9Ox1M5+ctErjMe+0cevZKo63HP6OTo14Qun1F4WRSU
   uIhZi0Iwrc/dwyPKVnVog2u4Ccd3ixull0EM7OpuE3zxZwY66aiOcT3v6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="304463661"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="304463661"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 15:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630098738"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="630098738"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 20 Oct 2022 15:13:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oldn6-00AnNS-2p;
        Fri, 21 Oct 2022 01:13:28 +0300
Date:   Fri, 21 Oct 2022 01:13:28 +0300
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
        marpagan@redhat.com
Subject: Re: [PATCH v4 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Message-ID: <Y1HICEwvk+ZdgdqU@smile.fi.intel.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020212610.697729-5-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Oct 20, 2022 at 02:26:10PM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.

...

> +#include <linux/bitfield.h>

Where is device.h?

> +#include <linux/dfl.h>

> +#include <linux/io-64-nonatomic-lo-hi.h>

User?

> +#include <linux/kernel.h>

Try to use what is really needed, yet this one may be still needed for
something like ARRAY_SIZE().

> +#include <linux/module.h>
> +#include <linux/serial.h>
> +#include <linux/serial_8250.h>

Missed types.h.

...

> +	ret = dfl_uart_get_params(dfl_dev, &uart);

> +

Redundant blank line.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed uart feature walk\n");

-- 
With Best Regards,
Andy Shevchenko


