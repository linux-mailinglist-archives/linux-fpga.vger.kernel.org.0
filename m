Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6D350681C
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Apr 2022 11:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350443AbiDSJzo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Apr 2022 05:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350442AbiDSJzn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Apr 2022 05:55:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5476920BFD;
        Tue, 19 Apr 2022 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650361981; x=1681897981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jfHt7wB5XGMSPzgSoV7ck75X/YUam3lD2caa7ddZDys=;
  b=jJzixJYZOk7IjXnWaZ0RrcNxJO4WRWe9lKOMXYok23NrNoYV30sVbZPZ
   OqYErJyYRPhjn6NqwCCxiIb07MKCprWDazrJg0E4WuaRTYkOARmm02+bs
   HBMuz7s6l33lRfPXRmlRt5r1CqByQ4vhJmUXBJQMFBxAAuVPDkc3ZQov/
   ycIw2cdsmw8rUJC2k9h7XVfO5kHKH5nSj99C5VexZdgMBNjV/l7qW6Eom
   Y5th6TrbDCaX2puUBcoI0pqUYvEDHQgO7WrnFgkFcJWfz/5X6fNMelrj7
   sP3uPh3VonlnzJKBqw+bw/8NzYunePizqxCbf78CfnnQTWcafTI4wI1Oe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263485752"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="263485752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 02:53:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="576022673"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 19 Apr 2022 02:52:57 -0700
Date:   Tue, 19 Apr 2022 17:45:21 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     Joe Perches <joe@perches.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: Re: [PATCH v4 2/5] fpga: fix for coding style issues
Message-ID: <20220419094521.GA322948@yilunxu-OptiPlex-7050>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
 <20220416133719.3382895-3-nava.manne@xilinx.com>
 <ac22068dad06fd61f2e82c0bf7c0f58a4e5df050.camel@perches.com>
 <SN6PR02MB45763D1B949353F99AAFE7D8C2F39@SN6PR02MB4576.namprd02.prod.outlook.com>
 <d56ad1bc0ef918cc8395b7c0ec7bdd10baf4c1f6.camel@perches.com>
 <SN6PR02MB45761359B029B065092F8691C2F29@SN6PR02MB4576.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB45761359B029B065092F8691C2F29@SN6PR02MB4576.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Apr 19, 2022 at 08:15:57AM +0000, Nava kishore Manne wrote:
> Hi Joe,
> 
> 	Please find my response inline.
> 
> > -----Original Message-----
> > From: Joe Perches <joe@perches.com>
> > Sent: Monday, April 18, 2022 6:04 PM
> > To: Nava kishore Manne <navam@xilinx.com>; mdf@kernel.org;
> > hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com; Michal Simek
> > <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> > <git@xilinx.com>
> > Subject: Re: [PATCH v4 2/5] fpga: fix for coding style issues
> > 
> > On Mon, 2022-04-18 at 09:54 +0000, Nava kishore Manne wrote:
> > > Hi Joe,
> > >
> > > 	Please find my response inline.
> > >
> > > > -----Original Message-----
> > > > From: Joe Perches <joe@perches.com>
> > > > Sent: Saturday, April 16, 2022 10:29 PM
> > 
> > > > On Sat, 2022-04-16 at 19:07 +0530, Nava kishore Manne wrote:
> > > > > fixes the below checks reported by checkpatch.pl Lines should not
> > > > > end with a '('
> > > > > Alignment should match open parenthesis
> > > >
> > > > in fpga-mgr:
> > > > 	Another possibillty would be to change the function arguments
> > > >
> 
> This API is there for a long back. Not sure changing the function arguments is fine or Not.
> @yilun: Is it ok to change the function arguments?

Joe's example code below doesn't actually change any function definition.
It just tries to store the value of 'min(mgr->mops->initial_header_size, count)'
in 'count', thus to reduce the length of the 'fpga_mgr_write_init(...)'
expression.

So I think it is OK.

Thanks,
Yilun

> 
> > > > and
> > > >
> > > > in fpga-region:
> > > > 	Ideally keep the include declaration and definition styles synced
> > >
> 
> Will fix it in next version.
> 
> Regards,
> Navakishore.
