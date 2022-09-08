Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36B55B2855
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Sep 2022 23:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiIHVRH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Sep 2022 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIHVRG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Sep 2022 17:17:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DFDC32F7;
        Thu,  8 Sep 2022 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662671825; x=1694207825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WCfMZhbDQ5gEis6Z2V2kC1NDXjb3rrNnL4l392+aqgw=;
  b=NwrDHLkFG4hUa/ZF27CxCDhSKpDG+hzLyCO80b9DmXrMKCNpOO+KHy1c
   /mXAvzN+M5yWzc13QMzyv7vDSD6StMV4LRd/SmhlixaC5N8BURPkHo6St
   T2ZZQh4w2txE2oHOuCB5XaQY/CQO/c0g3pjh5ln4AHqePiMHav5Kbk8Cd
   TgOtea7rBM7PyZ3j5wQtCGTiuK4g8ikMyhoP+L5HYmv+qwvQJsxXgJdzG
   8DRYYMOTiMt7NZ04SHuyFUJhzGuMihG/3HCdX8S+vMDuKxKPgzZvUJiqp
   UJ9k+4CXrqzSO4P1dsPHEWPe42JQXZyloHITj8yQXeZ97SMR8rbABDWfp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284346824"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="284346824"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 14:17:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="683389519"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 14:16:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWOtL-00AJUn-3A;
        Fri, 09 Sep 2022 00:16:55 +0300
Date:   Fri, 9 Sep 2022 00:16:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v1 5/5] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Message-ID: <Yxpbx0Tclqy4O9cR@smile.fi.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-6-matthew.gerlach@linux.intel.com>
 <YxesjfoBagiC3gGE@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2209081049290.61321@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209081049290.61321@rhweight-WRK1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Sep 08, 2022 at 11:27:03AM -0700, matthew.gerlach@linux.intel.com wrote:
> On Tue, 6 Sep 2022, Andy Shevchenko wrote:
> > On Tue, Sep 06, 2022 at 12:04:26PM -0700, matthew.gerlach@linux.intel.com wrote:

...

> > > +	dev_dbg(dfluart->dev, "UART_CLK_ID %llu Hz\n", dfluart->uart_clk);
> > 
> > Isn't this available via normal interfaces to user?
> 
> I am not sure what "normal interfaces to user" you are referring to.  The
> code is just trying to read the frequency of the input clock to the uart
> from a DFH paramter.

I mean dev_dbg() call. The user can get uart_clk via one of the UART/serial
ABIs (don't remember which one, though).


...

> > > +#define FME_FEATURE_ID_UART 0x24
> > 
> > Purpose of this definition? For me with or without is still an ID.
> 
> I don't think I understand the question. Is the name of the macro unclear,
> or do you think it is not necessary?

I mean how the definition is useful / useless. I.o.w. I think it's not
necessary.

-- 
With Best Regards,
Andy Shevchenko


