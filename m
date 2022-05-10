Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF20521DE4
	for <lists+linux-fpga@lfdr.de>; Tue, 10 May 2022 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbiEJPRK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 May 2022 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345333AbiEJPPa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 May 2022 11:15:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393C26CC70;
        Tue, 10 May 2022 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652194239; x=1683730239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kuBWY9TEKTGdwQx+mxQIXLEMUra6xrQy6VM9kB3SEok=;
  b=nNl1qZyO//+iCcFyMgKyF3xotE9tlwItLaOvNtv71/A9MCyh0IlWLdhB
   4DP4cFoCqNFnKs+ZjkKTUUbYi46/aJpjFtaohBjvaJ44vOcvmNzDKqSk0
   Md/HtD06AI9LFrIlqHOB8HqyY0QuNnCAldf+4TEQBDlUG6N37On7iH+HI
   iTeRs1KUJFEWyAuSpY+tWykX5OHdtWJ9rIm6cBEjiJwDOqspr290zycwP
   CJYHWIn9pqG2GL2wD8bfgj+YfP8pfB3Wd2no9I349W+zhlK+92LMkzxWE
   hiWFd9EIafqHyshyb83QTN79lQ+ObFzAxN0yezfLj5NxTVccpRrIblv+j
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="251444269"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="251444269"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="519786276"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2022 07:50:36 -0700
Date:   Tue, 10 May 2022 22:42:38 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Nava kishore Manne <navam@xilinx.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Message-ID: <20220510144238.GA481427@yilunxu-OptiPlex-7050>
References: <YnkE8AbimDa7sfN8@kili>
 <b1448881-4a68-0bc4-b828-0b9c79ffdf11@redhat.com>
 <SN6PR02MB4576F78E793E7C0EE2A0A4FDC2C69@SN6PR02MB4576.namprd02.prod.outlook.com>
 <0668a373-1101-5c34-31f1-d8435c59680d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0668a373-1101-5c34-31f1-d8435c59680d@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 10, 2022 at 05:21:59AM -0700, Tom Rix wrote:
> 
> On 5/9/22 8:15 AM, Nava kishore Manne wrote:
> > Hi Tom,
> > 
> > 	Please find my response inline.
> > 
> > > -----Original Message-----
> > > From: Tom Rix <trix@redhat.com>
> > > Sent: Monday, May 9, 2022 6:14 PM
> > > To: Dan Carpenter <dan.carpenter@oracle.com>; Moritz Fischer
> > > <mdf@kernel.org>; Nava kishore Manne <navam@xilinx.com>; Xu Yilun
> > > <yilun.xu@intel.com>; Wu Hao <hao.wu@intel.com>
> > > Cc: Michal Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org; kernel-
> > > janitors@vger.kernel.org
> > > Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
> > > 
> > > 
> > > On 5/9/22 5:11 AM, Dan Carpenter wrote:
> > > > The type needs to be u8.  The type was accidentally changed to char as
> > > > a cleanup.  Unfortunately, that meant that the zynq_fpga_has_sync()
> > > > function never returns true.  This bug was detected by Smatch and Clang:
> > > > 
> > > > drivers/fpga/zynq-fpga.c:245 zynq_fpga_has_sync() warn: impossible
> > > condition '(buf[2] == 153) => ((-128)-127 == 153)'
> > > > drivers/fpga/zynq-fpga.c:246 zynq_fpga_has_sync() warn: impossible
> > > condition '(buf[3] == 170) => ((-128)-127 == 170)'
> > > > drivers/fpga/zynq-fpga.c:246:14: warning: result of comparison of
> > > > constant 170 with expression of type 'const char' is always false
> > > > [-Wtautological-constant-out-of-range-compare]
> > > >                          buf[3] == 0xaa)
> > > >                          ~~~~~~ ^  ~~~~
> > > > drivers/fpga/zynq-fpga.c:245:50: warning: result of comparison of
> > > > constant 153 with expression of type 'const char' is always false
> > > > [-Wtautological-constant-out-of-range-compare]
> > > >                      if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
> > > >                                                              ~~~~~~ ^
> > > > ~~~~
> > > > 
> > > > Fixes: ada14a023a64 ("fpga: zynq: Fix incorrect variable type")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > > The ada14a023a64 ("fpga: zynq: Fix incorrect variable type") patch
> > > > went through six of revisions.  The kbuild bug found this bug early on
> > > > but the author ingored kbuild-bot and kept resending the buggy patch
> > > > anyway.
> > > > 
> > > > After the patch was merged then I sent a separate bug report and Xu
> > > > Yilun asked about why only the author was on the CC list for the first
> > > > bug reports.  A valid question, definitely.  I will poke the kbuild
> > > > devs about this.
> > > > 
> > > > Hm...  Actually looking through the list there have been a bunch of
> > > > bug reports about this because both Smatch and Clang complain so
> > > > kbuild sends duplicate warnings for this type of bug.  And then kbuild
> > > > sends another to say "This issue is still remaining" warning.  And
> > > > then Xu Yilun sent an email "Kbuild-bot is still complaining.  Please
> > > > don't forget to fix this."  So that's at least four public emails
> > > > about this and one or two private emails directly from kbuild-bot to the
> > > author.
> > > > The kbuild-bot wanted to send *another* warning today, but I decided
> > > > to send a fix instead.
> > > > 
> > > > LOL.
> > > > 
> > > >    drivers/fpga/zynq-fpga.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c index
> > > > 6beaba9dfe97..426aa34c6a0d 100644
> > > > --- a/drivers/fpga/zynq-fpga.c
> > > > +++ b/drivers/fpga/zynq-fpga.c
> > > > @@ -239,7 +239,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
> > > >     * the correct byte order, and be dword aligned. The input is a Xilinx .bin
> > > >     * file with every 32 bit quantity swapped.
> > > >     */
> > > > -static bool zynq_fpga_has_sync(const char *buf, size_t count)
> > > > +static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
> > > This is called from zynq_fpga_ops_write_init, a fpga_manager_ops function
> > > that
> > > 
> > > uses 'const char *' as a type for its write() buf's.
> > > 
> > > I think const u8 * would be a better type for all of the fpga_manager
> > > instances.
> > > 
> > > If folks agree, I'll make the change.
> > > 
> > I agree, please change it to u8
> 
> I was hoping one of the fpga/ maintainers would chime in.

As I said before, I think const char *buf for write_init() is OK.

> 
> Though it seems obvious that the type-specifier should be unsigned, this is
> a general interface change to the subsystem.

Searching over all kernel code, we can find many const char *buf/buf[], and
also many const u8 *buf/buf[], const unsigned char *buf/buf[]. I think
they are all good. They are just a block of data and people don't care
about their format. So signed or unsigned is not important.

If a specific driver have its own understanding of the data block and
want to parse it, just type casting it as needed to u8/s8/u16/s16 ...

So const char/u8/unsigned char * are all good to me, but for now I don't see
the necessity changing to one another for all fpga drivers.

Thanks,
Yilun

> 
> I would rather have buy in before spending a couple of days doing the change
> and having it rejected.
> 
> Tom
> 
> > 
> > Regards,
> > Nava kishore.
