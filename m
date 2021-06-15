Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574963A77F4
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Jun 2021 09:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFOH3d (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Jun 2021 03:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhFOH33 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Jun 2021 03:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1ACE600CD;
        Tue, 15 Jun 2021 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623742045;
        bh=6E2jASHKlmHdMb15628SwWOH4StarhjrsgR8qI9zr2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfI5IeY9beiYabNC8lzqBqRNIMdAo4hwrGMRV1AriX7sMV2mJxP3unzyfAzZVUKJ2
         8hHcTnCwWcpREILj3/i7UtAoeLSzODrCBfNcd7j56AhDRd13yHMAaTTecnUanLq+y6
         BxBXgvIera1WJHU2glvsI/MuxsTI42I7ox6sv/EI=
Date:   Tue, 15 Jun 2021 09:27:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 8/8] fpga: region: Use standard dev_release for class
 driver
Message-ID: <YMhWWucqaBXauzk/@kroah.com>
References: <20210614170909.232415-1-mdf@kernel.org>
 <20210614170909.232415-9-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614170909.232415-9-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 14, 2021 at 10:09:09AM -0700, Moritz Fischer wrote:
> From: Russ Weight <russell.h.weight@intel.com>
> 
> The FPGA region class driver data structure is being treated as a managed
> resource instead of using standard dev_release call-back to release the
> class data structure. This change populates the class.dev_release function
> and changes the fpga_region_free() function to call put_device().
> It also changes fpga_region_unregister() to call device_del() instead
> of device_unregister().

Same problem as the other ones :(
