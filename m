Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E65642F9
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Jul 2019 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfGJHjY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Jul 2019 03:39:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:32077 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfGJHjY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Jul 2019 03:39:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 00:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="176757754"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2019 00:39:21 -0700
Date:   Wed, 10 Jul 2019 15:22:34 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v2 00/11] FPGA DFL updates
Message-ID: <20190710072234.GA26817@hao-dev>
References: <1562286238-11413-1-git-send-email-hao.wu@intel.com>
 <20190710050746.GA28620@hao-dev>
 <20190710055417.GA5778@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710055417.GA5778@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 10, 2019 at 07:54:17AM +0200, Greg KH wrote:
> On Wed, Jul 10, 2019 at 01:07:46PM +0800, Wu Hao wrote:
> > On Fri, Jul 05, 2019 at 08:23:47AM +0800, Wu Hao wrote:
> > > Hi Greg / Moritz
> > > 
> > > This is v2 patchset which adds more features to FPGA DFL. This patchset
> > > is made on top of patch[1] and char-misc-next tree. Documentation patch
> > > for DFL is dropped from this patchset, and will resubmit it later to
> > > avoid conflict.
> > 
> > Hi Greg,
> > 
> > Did you get a chance to take a look at this new version to see if these
> > patches are good to take?
> > 
> > Hope we can catch up with the merge window.
> 
> You sent them last Friday.  I actually tried to not do kernel work last
> weekend.  The merge window opened up on Sunday.  My trees should have
> been closed last week, so no, this missed this merge window, I'll
> review these patches once 5.3-rc1 is out.

Oh..... I see...

Ok. Then let me resend it with documentation patch added back once 5.3-rc1
is out.

Thanks
Hao

> 
> thanks
> 
> greg k-h
