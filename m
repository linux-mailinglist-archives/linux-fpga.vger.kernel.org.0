Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50CEE13D28B
	for <lists+linux-fpga@lfdr.de>; Thu, 16 Jan 2020 04:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgAPDN6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Jan 2020 22:13:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:23725 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgAPDN6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Jan 2020 22:13:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 19:13:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,324,1574150400"; 
   d="scan'208";a="398127068"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2020 19:13:55 -0800
Date:   Thu, 16 Jan 2020 10:53:38 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Will Deacon <will@kernel.org>,
        mark.rutland@arm.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, yilun.xu@intel.com
Subject: Re: [PATCH v6 0/2] add performance reporting support to FPGA DFL
 drivers
Message-ID: <20200116025338.GA15263@hao-dev>
References: <1573622695-25607-1-git-send-email-hao.wu@intel.com>
 <20191125033412.GB890@hao-dev>
 <20191125080127.GC1809@willie-the-truck>
 <20191125080839.GA6227@hao-dev>
 <20191209024527.GA22625@hao-dev>
 <20191216010104.GA32154@yilunxu-OptiPlex-7050>
 <20200106023742.GA3980@hao-dev>
 <20200114055605.GA13574@hao-dev>
 <20200115051040.GA1389@epycbox.lan>
 <20200115081400.GA2978927@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115081400.GA2978927@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jan 15, 2020 at 09:14:00AM +0100, Greg KH wrote:
> On Tue, Jan 14, 2020 at 09:10:40PM -0800, Moritz Fischer wrote:
> > Hi Greg,
> > 
> > On Tue, Jan 14, 2020 at 01:56:05PM +0800, Wu Hao wrote:
> > > On Mon, Jan 06, 2020 at 10:37:42AM +0800, Wu Hao wrote:
> > > > On Mon, Dec 16, 2019 at 09:01:04AM +0800, Xu Yilum wrote:
> > > > > On Mon, Dec 09, 2019 at 10:45:27AM +0800, Wu Hao wrote:
> > > > > > On Mon, Nov 25, 2019 at 04:08:39PM +0800, Wu Hao wrote:
> > > > > > > On Mon, Nov 25, 2019 at 08:01:28AM +0000, Will Deacon wrote:
> > > > > > > > On Mon, Nov 25, 2019 at 11:34:12AM +0800, Wu Hao wrote:
> > > > > > > > > Hi Will and Mark,
> > > > > > > > > 
> > > > > > > > > Could you please help us on review this patchset? as this patchset mainly 
> > > > > > > > > introduced a new perf driver following the similar way as drivers/perf/*.
> > > > > > > > 
> > > > > > > > Why is it not under drivers/perf/, then?
> > > > > > > 
> > > > > > > Hi Will
> > > > > > > 
> > > > > > > Thanks for the quick response. This is one sub feature for DFL based FPGAs,
> > > > > > > and we plan to put this sub feature together with others, including related
> > > > > > > documentation. It only registers a standard perf pmu for its userspace
> > > > > > > interfaces.
> > > > > > > 
> > > > > > > > 
> > > > > > > > > This patchset has been submitted for a long time but didn't receive any
> > > > > > > > > comment after v4. we appreciate any review comments! thanks in advance. :)
> > > > > > > > 
> > > > > > > > Hmm, not sure I saw the previous versions. Guessing I wasn't on cc?
> > > > > > > 
> > > > > > > We switched to perf API from v4, and started ccing you and Mark from v5. :)
> > > > > > 
> > > > > > Hi Will
> > > > > > 
> > > > > > Did you get a chance to look into this patchset?
> > > > > > 
> > > > > > Thanks
> > > > > > Hao
> > > > > 
> > > > > Hi Will
> > > > > 
> > > > > Did you have time to look into this patchset? We have done review work
> > > > > for FPGA part. And as a perf driver, we appreciate your comments.
> > > > > 
> > > > > Thanks
> > > > > Yilun
> > > > 
> > > > Hi Will
> > > > 
> > > > Did you get a chance to look into this patchset these days? 
> > > > 
> > > > Actually we didn't receive any comments for a long time, if you are busy and
> > > > don't have enough time on this, do you know if someone else could help with
> > > > review and ack from perf driver point of view, or any other things we can do
> > > > to speed up this? Thanks in advance! 
> > > 
> > > Hi Moritz
> > > 
> > > Looks like still no response from Will. :(
> > > 
> > > Do you know someone else could help?
> > 
> > Do you have some feedback? I'm a bit confused on what to do in such a
> > situation, do I just take the patch if the maintainer doesn't respond
> > for a while?
> 
> Resend it and say something like "please review" or the like.  With the
> holidays and catching up from the holidays, this time of year is usually
> very backlogged for lots of reviewers.

Sure, will resend this patchset soon. Thanks!

Hao

> 
> greg k-h
