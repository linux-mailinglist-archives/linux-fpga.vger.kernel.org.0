Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA25F4AB
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jul 2019 10:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGDIgQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Jul 2019 04:36:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:37197 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfGDIgQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Jul 2019 04:36:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 01:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,450,1557212400"; 
   d="scan'208";a="362891372"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2019 01:36:14 -0700
Date:   Thu, 4 Jul 2019 16:19:31 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 05/15] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
Message-ID: <20190704081931.GA7391@hao-dev>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-6-mdf@kernel.org>
 <20190703175926.GA14649@kroah.com>
 <20190703233822.GB15825@hao-dev>
 <20190704053719.GA347@kroah.com>
 <20190704064208.GA2722@hao-dev>
 <20190704081713.GC6438@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704081713.GC6438@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 04, 2019 at 10:17:13AM +0200, Greg KH wrote:
> On Thu, Jul 04, 2019 at 02:42:08PM +0800, Wu Hao wrote:
> > On Thu, Jul 04, 2019 at 07:37:19AM +0200, Greg KH wrote:
> > > On Thu, Jul 04, 2019 at 07:38:22AM +0800, Wu Hao wrote:
> > > > On Wed, Jul 03, 2019 at 07:59:26PM +0200, Greg KH wrote:
> > > > > On Thu, Jun 27, 2019 at 05:49:41PM -0700, Moritz Fischer wrote:
> > > > > > From: Wu Hao <hao.wu@intel.com>
> > > > > > 
> > > > > > This patch adds virtualization support description for DFL based
> > > > > > FPGA devices (based on PCIe SRIOV), and introductions to new
> > > > > > interfaces added by new dfl private feature drivers.
> > > > > > 
> > > > > > [mdf@kernel.org: Fixed up to make it work with new reStructuredText docs]
> > > > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > > > > Acked-by: Alan Tull <atull@kernel.org>
> > > > > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > > > > ---
> > > > > >  Documentation/fpga/dfl.rst | 100 +++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 100 insertions(+)
> > > > > 
> > > > > This doesn't apply to my tree, where is this file created?
> > > > 
> > > > Hi Greg,
> > > > 
> > > > >From the cover-letter, Moritz mentioned, dfl.txt has been converted to .rst
> > > > in linux-next. I think this patch is created on top of that by Moritz.
> > > > 
> > > > "Note: I've seen that Mauro touched Documentation/fpga/dfl.rst in linux-next
> > > > commit c220a1fae6c5d ("docs: fpga: convert docs to ReST and rename to *.rst")"
> > > 
> > > Ok, but I can't take this patch just because the file is converted in
> > > someone else's tree :(
> > 
> > Oh.. if that patch is merged from fpga tree, then we wont have this problem. :(
> 
> You better not be basing your tree on linux-next :)
> 
> > So do you have any suggestions on what should i do now?
> > wait that patch goes to offical release, and then resubmit this patch?
> 
> Wait until the change hits Linus's tree and then resend it to me.

OK, get it! Thanks!

Hao

> 
> thanks,
> 
> greg k-h
