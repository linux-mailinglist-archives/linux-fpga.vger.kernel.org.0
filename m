Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63F5EFCA
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jul 2019 01:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfGCXzI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Jul 2019 19:55:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:17632 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGCXzI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Jul 2019 19:55:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 16:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="169293598"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2019 16:55:05 -0700
Date:   Thu, 4 Jul 2019 07:38:22 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 05/15] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
Message-ID: <20190703233822.GB15825@hao-dev>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-6-mdf@kernel.org>
 <20190703175926.GA14649@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703175926.GA14649@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 03, 2019 at 07:59:26PM +0200, Greg KH wrote:
> On Thu, Jun 27, 2019 at 05:49:41PM -0700, Moritz Fischer wrote:
> > From: Wu Hao <hao.wu@intel.com>
> > 
> > This patch adds virtualization support description for DFL based
> > FPGA devices (based on PCIe SRIOV), and introductions to new
> > interfaces added by new dfl private feature drivers.
> > 
> > [mdf@kernel.org: Fixed up to make it work with new reStructuredText docs]
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Alan Tull <atull@kernel.org>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  Documentation/fpga/dfl.rst | 100 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> 
> This doesn't apply to my tree, where is this file created?

Hi Greg,

From the cover-letter, Moritz mentioned, dfl.txt has been converted to .rst
in linux-next. I think this patch is created on top of that by Moritz.

"Note: I've seen that Mauro touched Documentation/fpga/dfl.rst in linux-next
commit c220a1fae6c5d ("docs: fpga: convert docs to ReST and rename to *.rst")"

Thanks
Hao

> 
> thanks,
> 
> greg k-h
