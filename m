Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064D25B58D2
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Sep 2022 12:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiILKyf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Sep 2022 06:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiILKyd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 12 Sep 2022 06:54:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7CCD86;
        Mon, 12 Sep 2022 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662980070; x=1694516070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hlBDz53+flWgbd1kP2vmgg1tnZZa5Xxm55qgoo4qc9s=;
  b=dIPYNesc2xZt7KeQw1jaf2uhrjVkgIfNX0/DAsa0vvescMQ8lS8/T5jg
   sjZsv+ECSZxRIVw/3UVjImEiBxG9tmBfWRzVe/gmVxCq7s2foNa0wsR+q
   6UFmvshu1anZ1i+eIxFSdm4s7EDIzbqptIGVzFPqJg6QUsQaXF/JQKmMb
   9aQ2JvPYfLXyWsnrpcamrYths152PjxGUpyChYg+Ph4SmiUwHBwZbgT+T
   xnzot4CJlpMAZiEAxzZT1WD/W06b8GWJVgeWs+IASJCNZCcu7cZR8SZ8s
   GMzd+i0dSeuMbc128KjzwmatEW91RGc21CHonzXaJ9pCIffaxZG5dNrH7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="297837609"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="297837609"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:54:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="567122849"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:54:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oXh52-001JDf-2Y;
        Mon, 12 Sep 2022 13:54:20 +0300
Date:   Mon, 12 Sep 2022 13:54:20 +0300
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
Message-ID: <Yx8P3ABrwYaMBRhn@smile.fi.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-6-matthew.gerlach@linux.intel.com>
 <YxesjfoBagiC3gGE@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2209081049290.61321@rhweight-WRK1>
 <Yxpbx0Tclqy4O9cR@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2209110850120.142336@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209110850120.142336@rhweight-WRK1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Sep 11, 2022 at 08:56:41AM -0700, matthew.gerlach@linux.intel.com wrote:
> On Fri, 9 Sep 2022, Andy Shevchenko wrote:
> > On Thu, Sep 08, 2022 at 11:27:03AM -0700, matthew.gerlach@linux.intel.com wrote:
> > > On Tue, 6 Sep 2022, Andy Shevchenko wrote:
> > > > On Tue, Sep 06, 2022 at 12:04:26PM -0700, matthew.gerlach@linux.intel.com wrote:

...

> > > > > +	dev_dbg(dfluart->dev, "UART_CLK_ID %llu Hz\n", dfluart->uart_clk);
> > > > 
> > > > Isn't this available via normal interfaces to user?
> > > 
> > > I am not sure what "normal interfaces to user" you are referring to.  The
> > > code is just trying to read the frequency of the input clock to the uart
> > > from a DFH paramter.
> > 
> > I mean dev_dbg() call. The user can get uart_clk via one of the UART/serial
> > ABIs (don't remember which one, though).
> 
> I don't think UART/serial ABIs to get the input clock frequency would be
> available until after the call to serial8250_register_8250_port()

Is it a problem?

> which needs the clock frequency as an input.

-- 
With Best Regards,
Andy Shevchenko


