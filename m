Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C496F520330
	for <lists+linux-fpga@lfdr.de>; Mon,  9 May 2022 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbiEIRHh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 May 2022 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239453AbiEIRHg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 May 2022 13:07:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7902C81B2;
        Mon,  9 May 2022 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652115817; x=1683651817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5OHRfsfFV8xA23hnT8SUJOmn4OFsZ4R9Z229GStcd2Y=;
  b=BFWR19bNJ44qqrfAHp/mbcVX/gNSI5b+SiL44z8/TG+rN73w1vavtc5d
   f22Bk4srJWaRkq2Xm7/iVYWuPZ8GfrpkXW5txE1fNPVjeO1cScj8yzEAv
   kOEZHXrtjBrJGlIJaJxx66foIIWanefaDsSJqO/YP1KDnmkczHbpCS+qE
   F2/hQxO5BK3LcnVWTfPAGS7rlj3XrGWTYeJIe1Dgt6SxP+m0yXmF/qlIl
   0IaH9JcgqMLSxV6tAH99icdueCe9R4EHSCs9MLu4jYBkwy3dYNHY51Ghy
   0IYqNN/yO++mbHfOoDwaSa9MBOyQGJp1xdWzzZoBIiZKfAN2zy4YDZP8/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249646042"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="249646042"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 10:03:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="565177613"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 09 May 2022 10:03:22 -0700
Date:   Tue, 10 May 2022 00:55:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Wu Hao <hao.wu@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Message-ID: <20220509165526.GB470015@yilunxu-OptiPlex-7050>
References: <YnkE8AbimDa7sfN8@kili>
 <b1448881-4a68-0bc4-b828-0b9c79ffdf11@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1448881-4a68-0bc4-b828-0b9c79ffdf11@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 09, 2022 at 05:43:58AM -0700, Tom Rix wrote:
> 
> On 5/9/22 5:11 AM, Dan Carpenter wrote:
> > The type needs to be u8.  The type was accidentally changed to char as
> > a cleanup.  Unfortunately, that meant that the zynq_fpga_has_sync()
> > function never returns true.  This bug was detected by Smatch and Clang:
> > 
> > drivers/fpga/zynq-fpga.c:245 zynq_fpga_has_sync() warn: impossible condition '(buf[2] == 153) => ((-128)-127 == 153)'
> > drivers/fpga/zynq-fpga.c:246 zynq_fpga_has_sync() warn: impossible condition '(buf[3] == 170) => ((-128)-127 == 170)'
> > 
> > drivers/fpga/zynq-fpga.c:246:14: warning: result of comparison of
> > constant 170 with expression of type 'const char' is always false
> > [-Wtautological-constant-out-of-range-compare]
> >                         buf[3] == 0xaa)
> >                         ~~~~~~ ^  ~~~~
> > drivers/fpga/zynq-fpga.c:245:50: warning: result of comparison of
> > constant 153 with expression of type 'const char' is always false
> > [-Wtautological-constant-out-of-range-compare]
> >                     if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
> >                                                             ~~~~~~ ^  ~~~~
> > 
> > Fixes: ada14a023a64 ("fpga: zynq: Fix incorrect variable type")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > The ada14a023a64 ("fpga: zynq: Fix incorrect variable type") patch went
> > through six of revisions.  The kbuild bug found this bug early on
> > but the author ingored kbuild-bot and kept resending the buggy patch
> > anyway.
> > 
> > After the patch was merged then I sent a separate bug report and Xu
> > Yilun asked about why only the author was on the CC list for the first
> > bug reports.  A valid question, definitely.  I will poke the kbuild
> > devs about this.
> > 
> > Hm...  Actually looking through the list there have been a bunch of bug
> > reports about this because both Smatch and Clang complain so kbuild
> > sends duplicate warnings for this type of bug.  And then kbuild
> > sends another to say "This issue is still remaining" warning.  And then
> > Xu Yilun sent an email "Kbuild-bot is still complaining.  Please don't
> > forget to fix this."  So that's at least four public emails about this
> > and one or two private emails directly from kbuild-bot to the author.
> > 
> > The kbuild-bot wanted to send *another* warning today, but I decided to
> > send a fix instead.
> > 
> > LOL.
> > 
> >   drivers/fpga/zynq-fpga.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> > index 6beaba9dfe97..426aa34c6a0d 100644
> > --- a/drivers/fpga/zynq-fpga.c
> > +++ b/drivers/fpga/zynq-fpga.c
> > @@ -239,7 +239,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
> >    * the correct byte order, and be dword aligned. The input is a Xilinx .bin
> >    * file with every 32 bit quantity swapped.
> >    */
> > -static bool zynq_fpga_has_sync(const char *buf, size_t count)
> > +static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
> 
> This is called from zynq_fpga_ops_write_init, a fpga_manager_ops function
> that
> 
> uses 'const char *' as a type for its write() buf's.
> 
> I think const u8 * would be a better type for all of the fpga_manager
> instances.

I don't think it's necessary to change the write_init(), const char *buf
is fine.

For this case, if the cleanup is necessary, just type casting the buf.

  zynq_fpga_has_sync((const u8 *)buf, count)

Thanks,
Yilun

> 
> If folks agree, I'll make the change.
> 
> Tom
> 
> >   {
> >   	for (; count >= 4; buf += 4, count -= 4)
> >   		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
