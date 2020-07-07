Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8380B216477
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jul 2020 05:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgGGDJv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 6 Jul 2020 23:09:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:5200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgGGDJu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 6 Jul 2020 23:09:50 -0400
IronPort-SDR: TQm/fi7DYbovaN8KqyDZCtV8TIf7/n6TONRzoggmLcFZF9Mn5O7Tnf/FMRsr1AwFJBPwsq5pz8
 WRlbDd/K+dyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149042851"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="149042851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 20:09:50 -0700
IronPort-SDR: QOBbccHx1aQWhYm4vM6O5Jh355QaPW+M95I3Om9ZPIhH1OYcxJX7ao+H1c/TlU8NDOY9IUiDEO
 Whua9BRXgMEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="283244650"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2020 20:09:47 -0700
Date:   Tue, 7 Jul 2020 11:05:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <moritz.fischer.private@gmail.com>
Cc:     Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bhu@redhat.com, mtosatti@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jun.j.tian@intel.com, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v7 0/7] Add interrupt support to FPGA DFL drivers
Message-ID: <20200707030547.GA6688@yilunxu-OptiPlex-7050>
References: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
 <20200622064806.GA5101@yilunxu-OptiPlex-7050>
 <c9a33ee6-67f2-36b8-0870-ebc038b929ce@redhat.com>
 <20200623052613.GB23037@yilunxu-OptiPlex-7050>
 <CAJYdmeM7ec4PMtRV+qJrMDA9V+yCEv-zPAnSCFjx1V2Ca-aw9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJYdmeM7ec4PMtRV+qJrMDA9V+yCEv-zPAnSCFjx1V2Ca-aw9g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz:

Do you have more concern on the last 4 patches?

Thanks in advance.

On Tue, Jun 23, 2020 at 03:42:07PM -0700, Moritz Fischer wrote:
> Will look at it this week.
> 
> - Moritz
> 
> On Mon, Jun 22, 2020 at 10:30 PM Xu Yilun <yilun.xu@intel.com> wrote:
> >
> > On Mon, Jun 22, 2020 at 05:27:20AM -0700, Tom Rix wrote:
> > > In addition to reviewing, I have run these changes on the pac a10 card and while i do not have an afu using interrupts, I have exercised some of the new interfaces.
> > >
> > > The most useful i have submitted to selftests drivers/fpga.  In the future, this would be a good place to put other fpga unit tests.
> > >
> > > The selftest patch depends on this change.
> > >
> > > So you can also add
> > >
> > > Tested-by: Tom Rix <trix@redhat.com>
> >
> > Yes I'll add your Tested-by tag.
> >
> > Thanks,
> > Yilun
> >
> > >
> > > Tom
> > >
> > > On 6/21/20 11:48 PM, Xu Yilun wrote:
> > > > Hi Moritz:
> > > >
> > > > Could you please help review the patchset when you have time?
> > > >
> > > > You have already reviewed the first 3 patches some time ago. The
> > > > comments are all fixed. Hao and Redhat guys also have done several
> > > > rounds of review. The patches are all Acked-by Hao, reviewed by
> > > > Marcelo & Tom.
> > > >
> > > > There is little change to the code for several months, seems it stays
> > > > ready and just need your final Ack.
> > > >
> > > > Actually this is the last feature for our first generation PAC A10 Card,
> > > > and is important for users to have the full support.
> > > >
> > > > We really need your help on code review ...
> > > >
> > > > Many thanks!
> > > > Yilun
> > > >
> > > > On Tue, Jun 16, 2020 at 12:08:41PM +0800, Xu Yilun wrote:
> > > >> This patchset add interrupt support to FPGA DFL drivers.
> > > >>
> > > >> With these patches, DFL driver will parse and assign interrupt resources
> > > >> for enumerated feature devices and their sub features.
> > > >>
> > > >> This patchset also introduces a set of APIs for user to monitor DFL
> > > >> interrupts. Three sub features (DFL FME error, DFL AFU error and user
> > > >> interrupt) drivers now support these APIs.
> > > >>
> > > >> Patch #1: DFL framework change. Accept interrupt info input from DFL bus
> > > >>           driver, and add interrupt parsing and assignment for feature
> > > >>           sub devices.
> > > >> Patch #2: DFL pci driver change, add interrupt info on DFL enumeration.
> > > >> Patch #3: DFL framework change. Add helper functions for feature sub
> > > >>           device drivers to handle interrupt and notify users.
> > > >> Patch #4: Add interrupt support for AFU error reporting sub feature.
> > > >> Patch #5: Add interrupt support for FME global error reporting sub
> > > >>           feature.
> > > >> Patch #6: Add interrupt support for a new sub feature, to handle user
> > > >>           interrupts implemented in AFU.
> > > >> Patch #7: Documentation for DFL interrupt handling.
> > > >>
> > > >> Main changes from v1:
> > > >>  - Early validating irq table for each feature in parse_feature_irq()
> > > >>    in Patch #1.
> > > >>  - Changes IOCTL interfaces. use DFL_FPGA_FME/PORT_XXX_GET_IRQ_NUM
> > > >>    instead of DFL_FPGA_FME/PORT_XXX_GET_INFO, delete flag field for
> > > >>    DFL_FPGA_FME/PORT_XXX_SET_IRQ param
> > > >>
> > > >> Main changes from v2:
> > > >>  - put parse_feature_irqs() inside create_feature_instance().
> > > >>  - refines code for dfl_fpga_set_irq_triggers, delete local variable j.
> > > >>  - put_user() instead of copy_to_user() for DFL_FPGA_XXX_GET_IRQ_NUM IOCTL
> > > >>
> > > >> Main changes from v3:
> > > >>  - rebased to 5.7-rc1.
> > > >>  - fail the dfl enumeration when irq parsing error happens.
> > > >>  - Add 2 helper functions in dfl.c to handle generic irq ioctls in feature
> > > >>    drivers.
> > > >>
> > > >> Main changes from v4:
> > > >>  - Minor fixes for Hao's comments.
> > > >>
> > > >> Main changes from v5:
> > > >>  - Remove unnecessary type casting in Patch #1 & #3.
> > > >>  - Minor fixes for Moritz's comments.
> > > >>
> > > >> Main changes from v6:
> > > >>  - Add the header file <linux/interrupt.h> for Patch #1, to fix build
> > > >>    error on ARCH=xtensa
> > > >>  - Minor fixes in Patch #2 & #3.
> > > >>
> > > >> Xu Yilun (7):
> > > >>   fpga: dfl: parse interrupt info for feature devices on enumeration
> > > >>   fpga: dfl: pci: add irq info for feature devices enumeration
> > > >>   fpga: dfl: introduce interrupt trigger setting API
> > > >>   fpga: dfl: afu: add interrupt support for port error reporting
> > > >>   fpga: dfl: fme: add interrupt support for global error reporting
> > > >>   fpga: dfl: afu: add AFU interrupt support
> > > >>   Documentation: fpga: dfl: add descriptions for interrupt related
> > > >>     interfaces.
> > > >>
> > > >>  Documentation/fpga/dfl.rst    |  19 +++
> > > >>  drivers/fpga/dfl-afu-error.c  |  17 +++
> > > >>  drivers/fpga/dfl-afu-main.c   |  32 +++++
> > > >>  drivers/fpga/dfl-fme-error.c  |  18 +++
> > > >>  drivers/fpga/dfl-fme-main.c   |   6 +
> > > >>  drivers/fpga/dfl-pci.c        |  76 +++++++++--
> > > >>  drivers/fpga/dfl.c            | 310 ++++++++++++++++++++++++++++++++++++++++++
> > > >>  drivers/fpga/dfl.h            |  57 ++++++++
> > > >>  include/uapi/linux/fpga-dfl.h |  82 +++++++++++
> > > >>  9 files changed, 608 insertions(+), 9 deletions(-)
> > > >>
> > > >> --
> > > >> 2.7.4
