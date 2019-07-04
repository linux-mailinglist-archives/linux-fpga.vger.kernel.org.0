Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A935F250
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jul 2019 07:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfGDFhX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Jul 2019 01:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfGDFhX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Jul 2019 01:37:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C196221882;
        Thu,  4 Jul 2019 05:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562218642;
        bh=68YBiqzzC9CxoG3EOXFEd7zfUoObV13BramhGxgq4EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMCLjHRhbTr+XLlY5Wmx9Lfvnuxxo2fOYj1MUcm2r+lbfZEBYUGoc8D7hV2gjFCjR
         Upxzl0lEyjc+ubA3jy+1ooLnD8/nKhGZFByYMCPots1lDAtH1OV1VGMskMg5M/jM/r
         41POixgfrC3Qmjej+NNYh4ArLvHGTNNfXjjzTyFc=
Date:   Thu, 4 Jul 2019 07:37:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 05/15] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
Message-ID: <20190704053719.GA347@kroah.com>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-6-mdf@kernel.org>
 <20190703175926.GA14649@kroah.com>
 <20190703233822.GB15825@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703233822.GB15825@hao-dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 04, 2019 at 07:38:22AM +0800, Wu Hao wrote:
> On Wed, Jul 03, 2019 at 07:59:26PM +0200, Greg KH wrote:
> > On Thu, Jun 27, 2019 at 05:49:41PM -0700, Moritz Fischer wrote:
> > > From: Wu Hao <hao.wu@intel.com>
> > > 
> > > This patch adds virtualization support description for DFL based
> > > FPGA devices (based on PCIe SRIOV), and introductions to new
> > > interfaces added by new dfl private feature drivers.
> > > 
> > > [mdf@kernel.org: Fixed up to make it work with new reStructuredText docs]
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > Acked-by: Alan Tull <atull@kernel.org>
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > ---
> > >  Documentation/fpga/dfl.rst | 100 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 100 insertions(+)
> > 
> > This doesn't apply to my tree, where is this file created?
> 
> Hi Greg,
> 
> >From the cover-letter, Moritz mentioned, dfl.txt has been converted to .rst
> in linux-next. I think this patch is created on top of that by Moritz.
> 
> "Note: I've seen that Mauro touched Documentation/fpga/dfl.rst in linux-next
> commit c220a1fae6c5d ("docs: fpga: convert docs to ReST and rename to *.rst")"

Ok, but I can't take this patch just because the file is converted in
someone else's tree :(
