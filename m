Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F8B5B555
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Jul 2019 08:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGAGxU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Jul 2019 02:53:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:59538 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfGAGxU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Jul 2019 02:53:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2019 23:47:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,437,1557212400"; 
   d="scan'208";a="361732774"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2019 23:47:07 -0700
Date:   Mon, 1 Jul 2019 14:30:27 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, yilun.xu@intel.com,
        gregkh@linuxfoundation.org, atull@kernel.org
Subject: Re: [PATCH v4 05/15] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
Message-ID: <20190701063027.GA3824@hao-dev>
References: <1561610695-5414-1-git-send-email-hao.wu@intel.com>
 <1561610695-5414-6-git-send-email-hao.wu@intel.com>
 <20190628011256.GB5671@archbook>
 <20190628021333.GB9994@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628021333.GB9994@hao-dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 28, 2019 at 10:13:33AM +0800, Wu Hao wrote:
> On Thu, Jun 27, 2019 at 06:12:56PM -0700, Moritz Fischer wrote:
> > Hi Wu,
> > 
> > On Thu, Jun 27, 2019 at 12:44:45PM +0800, Wu Hao wrote:
> > > This patch adds virtualization support description for DFL based
> > > FPGA devices (based on PCIe SRIOV), and introductions to new
> > > interfaces added by new dfl private feature drivers.
> > > 
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > Acked-by: Alan Tull <atull@kernel.org>
> > > ---
> > >  Documentation/fpga/dfl.txt | 101 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 101 insertions(+)
> > > 
> > > diff --git a/Documentation/fpga/dfl.txt b/Documentation/fpga/dfl.txt
> > > index 6df4621..a22631f 100644
> > > --- a/Documentation/fpga/dfl.txt
> > > +++ b/Documentation/fpga/dfl.txt
> > 
> > This got re{named,formatted} in linux-next. I've tried to fix it before sending it
> > to Greg.
> 
> Many Thanks for the help! :)
> 
> I think I need rebase thermal/power management (hwmon) and perf support
> patchsets as they update this documentation file too. But I feel we
> can go ahead on code review for the other patches, if there are some
> comments received and something need to fix, i can put fixes together in
> the next version.

Hi Moritz,

I found some descriptions are dropped unexpectedly in your patch, so I 
prepared and sent out a new version (v2) to fix it. Please let me know if
you prefer an increamental patch.

Thanks!
Hao

> 
> Thanks
> Hao
> 
> > 
> > Thanks,
> > Moritz
