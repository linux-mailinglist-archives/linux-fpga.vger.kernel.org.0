Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62DD5F7A8B
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Oct 2022 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJGP2J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Oct 2022 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJGP2I (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Oct 2022 11:28:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA580BE2F3;
        Fri,  7 Oct 2022 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665156487; x=1696692487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMKbVPcQscfXLNGBf0b+l8Dkp2+aRAqwacpODPYyXMA=;
  b=krqWPZ+O34UMSydsPtvMv0uD6kIskYPsnbcBrBuNWsjeUB2S3i8SYi4G
   Iy1WB8+7OifXS/O9/963QXQ9EctmZhNpI1ZzVswEe6d+PPCIjafIaLWzL
   w5RSeZsiDroCz0bFGQEcrqNBjNbIc8ykL7vse6lT0cuiwZolRdGWfnS68
   G9NjYikhW8I+8QHtdU1LNbDbRDsHWqxHqaRKsPVOiVGKwbFliExpEVtie
   k4LwJKYRIm8lvNrUI2B557WlVKlhOSAd/T5WkM9emYsTFUK3QLomUjhaj
   lJAqXq2XSrE/w0+mJvhNx1EPDSgdlWS+E1NjQ/L3PGT1hzGCcfkNN1EjE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="303740972"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="303740972"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 08:28:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="627484351"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="627484351"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2022 08:28:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ogpGa-003eke-17;
        Fri, 07 Oct 2022 18:28:00 +0300
Date:   Fri, 7 Oct 2022 18:28:00 +0300
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
        johan@kernel.org, lukas@wunner.de,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Message-ID: <Y0BFgAJoA+L15/9A@smile.fi.intel.com>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
 <20221004143718.1076710-5-matthew.gerlach@linux.intel.com>
 <YzxRxo8jL7rB1+px@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2210060940150.1988353@rhweight-WRK1>
 <Yz8T8GdzMLyAKIMb@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2210061517300.1772307@rhweight-WRK1>
 <Yz/uTGeNaOP4Btli@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2210070807340.2155700@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210070807340.2155700@rhweight-WRK1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Oct 07, 2022 at 08:10:34AM -0700, matthew.gerlach@linux.intel.com wrote:
> On Fri, 7 Oct 2022, Andy Shevchenko wrote:

...

> In the Kconfig, I think the driver fits into the section, Misc.
> options/drivers.  Within this section, I think SERIAL_8250_DFL should go
> before SERIAL_8250_DW to approximate alphabetical ordering.  Similarly, I
> think 8250_dfl.o should go above 8250_dw.o in the Makefile.

Sounds good to me!

-- 
With Best Regards,
Andy Shevchenko


