Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1EF21309
	for <lists+linux-fpga@lfdr.de>; Fri, 17 May 2019 06:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfEQE10 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 May 2019 00:27:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:42690 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfEQE10 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 17 May 2019 00:27:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 21:27:25 -0700
X-ExtLoop1: 1
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2019 21:27:23 -0700
Date:   Fri, 17 May 2019 12:11:16 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 05/18] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
Message-ID: <20190517041116.GC20569@hao-dev>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-6-git-send-email-hao.wu@intel.com>
 <CANk1AXQSL8k=FOLv4_rLfRHBqOi=CW=yP3O8ch4VEa25cj9+Cw@mail.gmail.com>
 <CANk1AXQCp2ozUQDWz__MuiUeDLvGvrfqj3KUYmBa5Z34oxG8NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXQCp2ozUQDWz__MuiUeDLvGvrfqj3KUYmBa5Z34oxG8NQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 16, 2019 at 12:53:00PM -0500, Alan Tull wrote:
> On Thu, May 16, 2019 at 12:36 PM Alan Tull <atull@kernel.org> wrote:
> >
> > On Mon, Apr 29, 2019 at 4:12 AM Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> Most of this patchset looks ready to go upstream or nearly so with
> pretty straightforward changes .  Patches 17 and 18 need minor changes
> and please change the scnprintf in the other patches.  The patches
> that had nontrivial changes are the power and thermal ones involving
> hwmon.  I'm hoping to send up the patchset minus the hwmon patches in
> the next version if there's no unforseen issues.  If the hwmon patches
> are ready then also, that's great, but otherwise those patches don't
> need to hold up all the rest of the patchset.  How's that sound?

Hi Alan

Thanks for your time for reviewing this patchset.

This sounds good to me. Only thing here is, I need to split the patch which
updates documentation into 2 patches (to remove hwmon description in doc),
but for sure, it should be very easy. :)

Thanks
Hao

> 
> Alan
> 
> > >
> > > This patch adds virtualization support description for DFL based
> > > FPGA devices (based on PCIe SRIOV), and introductions to new
> > > interfaces added by new dfl private feature drivers.
> > >
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> >
> > Acked-by: Alan Tull <atull@kernel.org>
> >
> > Thanks,
> > Alan
