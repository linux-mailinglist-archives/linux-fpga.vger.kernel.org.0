Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5C050E1CD
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Apr 2022 15:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiDYNdM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242263AbiDYNcj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 09:32:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9445E40E48
        for <linux-fpga@vger.kernel.org>; Mon, 25 Apr 2022 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650893374; x=1682429374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bfjroYB5vJNs6Jtq7xB+NKQ1xiNPKmt2UoWnLi1zBVM=;
  b=TUpyfdLwJdNo0exkaX7DcXHSKFN2089GcJKp7Z3wPBj3PFhLWif/RVuC
   ynrsILmai+GHeMr4ThRpjuWINbxyg0rnWovnvYa64jCWgOjM8aWFLSmz2
   uwf6xb2TEFHn1Fpw7ZAYNSPMK3qniVfxW/6Dn9DFhfdb40h7hpQG+CsF8
   Ru5lw9uW61ROYB7VizaPE8jPDeK6z+lKuvqasaXDpSwE8BhCA0XQ0qyiG
   usiuk4IwqRVHMG3Qbgkcsy+nywzlnnEa0mp1XBgWRaS4m+STFxbQ/A34a
   XmEFDjkxRSNxSNZUMmwuxntFI6VjCYZd6mjkZwh/H7YhwVjAcq2gMJZyf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="247174106"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="247174106"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 06:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="557729889"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 25 Apr 2022 06:29:32 -0700
Date:   Mon, 25 Apr 2022 21:21:51 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     nava.manne@xilinx.com, Moritz Fischer <mdf@kernel.org>,
        lkp@intel.com, linux-fpga@vger.kernel.org
Subject: Re: [bug report] fpga: zynq: Fix incorrect variable type
Message-ID: <20220425132151.GA367066@yilunxu-OptiPlex-7050>
References: <YmaHxydsy/Ff1awV@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmaHxydsy/Ff1awV@kili>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Apr 25, 2022 at 02:36:39PM +0300, Dan Carpenter wrote:
> Hello Nava kishore Manne,
> 
> The patch ada14a023a64: "fpga: zynq: Fix incorrect variable type"
> from Apr 21, 2022, leads to the following Smatch static checker
> warning:
> 
> 	drivers/fpga/zynq-fpga.c:245 zynq_fpga_has_sync()
> 	warn: impossible condition '(buf[2] == 153) => ((-128)-127 == 153)'
> 
> drivers/fpga/zynq-fpga.c
>     242 static bool zynq_fpga_has_sync(const char *buf, size_t count)
>     243 {
>     244         for (; count >= 4; buf += 4, count -= 4)
> --> 245                 if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
>                                                                 ^^^^^^^^^^^^^^
> The patch changed the u8 to char.
> 
> The kbuild bot sent an email about this bug on Apr 4 but only Nava was
> on the CC and the warning was ignored.  This kind of a dangerous thing,
> because I tend to only send warnings once.
> 
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/4RFIS5FM43D2U26PX7ZL44AFA5RYBWX2/
> 
> There is a process issue somewhere.  Why was the linux-fpga@vger.kernel.org
> not CC'd on the original report?  Did you deliberately ask to be left
> off automated bug reports?

Thanks for the notification. I did't realize that linux-fpga@vger.kernel.org
is out of lkp report, it should not be our intent.

Anything I should do to get back in?

Thanks,
Yilun

> 
>     246                     buf[3] == 0xaa)
>     247                         return true;
>     248         return false;
>     249 }
> 
> regards,
> dan carpenter
