Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2EBB5F466
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jul 2019 10:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfGDIRR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Jul 2019 04:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfGDIRR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Jul 2019 04:17:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4BB218A3;
        Thu,  4 Jul 2019 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562228236;
        bh=TIGMTPqssXbpuxAXDNpvc6RYvMCtqyczO0QqKt1mwYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4T3CGmwURt4DXyu/Dpumwz1qUI1XTFsaNfUMqQtpUUjHxQ2I0yDND4ar1sjb7k8a
         7bJNpvuSC6o2egZfr9b2BR1J89S0SEfb19nTPOTAAOIpuXH5puHVdRTbTL9Btt9i/P
         C2SBjvALeC2cGEMV6xfMgBDofbg05UVMy9vwt4GE=
Date:   Thu, 4 Jul 2019 10:17:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 05/15] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
Message-ID: <20190704081713.GC6438@kroah.com>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-6-mdf@kernel.org>
 <20190703175926.GA14649@kroah.com>
 <20190703233822.GB15825@hao-dev>
 <20190704053719.GA347@kroah.com>
 <20190704064208.GA2722@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704064208.GA2722@hao-dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 04, 2019 at 02:42:08PM +0800, Wu Hao wrote:
> On Thu, Jul 04, 2019 at 07:37:19AM +0200, Greg KH wrote:
> > On Thu, Jul 04, 2019 at 07:38:22AM +0800, Wu Hao wrote:
> > > On Wed, Jul 03, 2019 at 07:59:26PM +0200, Greg KH wrote:
> > > > On Thu, Jun 27, 2019 at 05:49:41PM -0700, Moritz Fischer wrote:
> > > > > From: Wu Hao <hao.wu@intel.com>
> > > > > 
> > > > > This patch adds virtualization support description for DFL based
> > > > > FPGA devices (based on PCIe SRIOV), and introductions to new
> > > > > interfaces added by new dfl private feature drivers.
> > > > > 
> > > > > [mdf@kernel.org: Fixed up to make it work with new reStructuredText docs]
> > > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > > > Acked-by: Alan Tull <atull@kernel.org>
> > > > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > > > ---
> > > > >  Documentation/fpga/dfl.rst | 100 +++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 100 insertions(+)
> > > > 
> > > > This doesn't apply to my tree, where is this file created?
> > > 
> > > Hi Greg,
> > > 
> > > >From the cover-letter, Moritz mentioned, dfl.txt has been converted to .rst
> > > in linux-next. I think this patch is created on top of that by Moritz.
> > > 
> > > "Note: I've seen that Mauro touched Documentation/fpga/dfl.rst in linux-next
> > > commit c220a1fae6c5d ("docs: fpga: convert docs to ReST and rename to *.rst")"
> > 
> > Ok, but I can't take this patch just because the file is converted in
> > someone else's tree :(
> 
> Oh.. if that patch is merged from fpga tree, then we wont have this problem. :(

You better not be basing your tree on linux-next :)

> So do you have any suggestions on what should i do now?
> wait that patch goes to offical release, and then resubmit this patch?

Wait until the change hits Linus's tree and then resend it to me.

thanks,

greg k-h
