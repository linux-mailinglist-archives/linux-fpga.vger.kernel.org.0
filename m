Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320473BF3F6
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Jul 2021 04:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhGHC1V (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Jul 2021 22:27:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:62635 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhGHC1V (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 7 Jul 2021 22:27:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="209247383"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="209247383"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 19:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="498201106"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2021 19:24:38 -0700
Date:   Thu, 8 Jul 2021 10:19:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] bus: Make remove callback return void
Message-ID: <20210708021913.GB12358@yilunxu-OptiPlex-7050>
References: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
 <4c7210e4-76e4-07fe-a40c-a58e331d0a6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c7210e4-76e4-07fe-a40c-a58e331d0a6e@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 06, 2021 at 06:52:09AM -0700, Tom Rix wrote:
> 
> On 7/6/21 2:50 AM, Uwe Kleine-König wrote:
> > The driver core ignores the return value of this callback because there
> > is only little it can do when a device disappears.
> > 
> > This is the final bit of a long lasting cleanup quest where several
> > buses were converted to also return void from their remove callback.
> > Additionally some resource leaks were fixed that were caused by drivers
> > returning an error code in the expectation that the driver won't go
> > away.
> > 
> > With struct bus_type::remove returning void it's prevented that newly
> > implemented buses return an ignored error code and so don't anticipate
> > wrong expectations for driver authors.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > this patch depends on "PCI: endpoint: Make struct pci_epf_driver::remove
> > return void" that is not yet applied, see
> > https://lore.kernel.org/r/20210223090757.57604-1-u.kleine-koenig@pengutronix.de.
> > 
> > I tested it using allmodconfig on amd64 and arm, but I wouldn't be
> > surprised if I still missed to convert a driver. So it would be great to
> > get this into next early after the merge window closes.
> > 
> > I send this mail to all people that get_maintainer.pl emits for this
> > patch. I wonder how many recipents will refuse this mail because of the
> > long Cc: list :-)
> > 
> > Best regards
> > Uwe
> 
> >   drivers/fpga/dfl.c                        | 4 +---
> Reviewed-by: Tom Rix <trix@redhat.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
