Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15B813A0E7
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Jan 2020 07:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgANGQY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 14 Jan 2020 01:16:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:11960 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgANGQY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 14 Jan 2020 01:16:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 22:16:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="242352844"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2020 22:16:21 -0800
Date:   Tue, 14 Jan 2020 13:56:05 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, gregkh@linuxfoundation.org, yilun.xu@intel.com
Subject: Re: [PATCH v6 0/2] add performance reporting support to FPGA DFL
 drivers
Message-ID: <20200114055605.GA13574@hao-dev>
References: <1573622695-25607-1-git-send-email-hao.wu@intel.com>
 <20191125033412.GB890@hao-dev>
 <20191125080127.GC1809@willie-the-truck>
 <20191125080839.GA6227@hao-dev>
 <20191209024527.GA22625@hao-dev>
 <20191216010104.GA32154@yilunxu-OptiPlex-7050>
 <20200106023742.GA3980@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106023742.GA3980@hao-dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 06, 2020 at 10:37:42AM +0800, Wu Hao wrote:
> On Mon, Dec 16, 2019 at 09:01:04AM +0800, Xu Yilum wrote:
> > On Mon, Dec 09, 2019 at 10:45:27AM +0800, Wu Hao wrote:
> > > On Mon, Nov 25, 2019 at 04:08:39PM +0800, Wu Hao wrote:
> > > > On Mon, Nov 25, 2019 at 08:01:28AM +0000, Will Deacon wrote:
> > > > > On Mon, Nov 25, 2019 at 11:34:12AM +0800, Wu Hao wrote:
> > > > > > Hi Will and Mark,
> > > > > > 
> > > > > > Could you please help us on review this patchset? as this patchset mainly 
> > > > > > introduced a new perf driver following the similar way as drivers/perf/*.
> > > > > 
> > > > > Why is it not under drivers/perf/, then?
> > > > 
> > > > Hi Will
> > > > 
> > > > Thanks for the quick response. This is one sub feature for DFL based FPGAs,
> > > > and we plan to put this sub feature together with others, including related
> > > > documentation. It only registers a standard perf pmu for its userspace
> > > > interfaces.
> > > > 
> > > > > 
> > > > > > This patchset has been submitted for a long time but didn't receive any
> > > > > > comment after v4. we appreciate any review comments! thanks in advance. :)
> > > > > 
> > > > > Hmm, not sure I saw the previous versions. Guessing I wasn't on cc?
> > > > 
> > > > We switched to perf API from v4, and started ccing you and Mark from v5. :)
> > > 
> > > Hi Will
> > > 
> > > Did you get a chance to look into this patchset?
> > > 
> > > Thanks
> > > Hao
> > 
> > Hi Will
> > 
> > Did you have time to look into this patchset? We have done review work
> > for FPGA part. And as a perf driver, we appreciate your comments.
> > 
> > Thanks
> > Yilun
> 
> Hi Will
> 
> Did you get a chance to look into this patchset these days? 
> 
> Actually we didn't receive any comments for a long time, if you are busy and
> don't have enough time on this, do you know if someone else could help with
> review and ack from perf driver point of view, or any other things we can do
> to speed up this? Thanks in advance! 

Hi Moritz

Looks like still no response from Will. :(

Do you know someone else could help?

Thanks
Hao

> 
> Hao
> 
> > 
> > > 
> > > > 
> > > > Thanks
> > > > Hao
> > > > 
> > > > > 
> > > > > Will
