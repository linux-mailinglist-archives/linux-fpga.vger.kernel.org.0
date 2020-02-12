Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1596915A0A1
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2020 06:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgBLFah (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 Feb 2020 00:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgBLFah (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 12 Feb 2020 00:30:37 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5125F206ED;
        Wed, 12 Feb 2020 05:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581485436;
        bh=qMMyvm720VdVVCSl1mVWcGON0Q4rbh4HwTWMPxf8Xi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2mN3TRevFVhTFpbGQNOspuLlDZ2l6caQTgOOP7qmu/YZRKXwis492ykCJ2wRYgGo
         8PVxOmJRja77yyTaA2aAJ1JRxxAJvqInbde1Is/9CRwNiW6J86or52cwVJ7dgnqwBH
         2okebngu4syM3X7H5cOZeNdEo/BgON0zd4BaYmsY=
Date:   Tue, 11 Feb 2020 21:30:35 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Will Deacon <will@kernel.org>, mdf@kernel.org,
        mark.rutland@arm.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, yilun.xu@intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v7 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20200212053035.GA382718@kroah.com>
References: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
 <1581306469-22629-3-git-send-email-hao.wu@intel.com>
 <20200210163400.GA21900@willie-the-truck>
 <20200212031929.GB5645@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212031929.GB5645@hao-dev>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Feb 12, 2020 at 11:19:29AM +0800, Wu Hao wrote:
> On Mon, Feb 10, 2020 at 04:34:01PM +0000, Will Deacon wrote:
> > Hi,
> > 
> > On Mon, Feb 10, 2020 at 11:47:49AM +0800, Wu Hao wrote:
> > > This patch adds support for performance reporting private feature
> > > for FPGA Management Engine (FME). Now it supports several different
> > > performance counters, including 'basic', 'cache', 'fabric', 'vtd'
> > > and 'vtd_sip'. It allows user to use standard linux tools to access
> > > these performance counters.
> > 
> > I had a quick look at this, and it mostly looks alright to me. Just a few
> > high-level comments/questions:
> 
> Hi Will
> 
> Thanks a lot for the review! :)
> 
> > 
> >   - I would still prefer for the PMU drivers to live under drivers/perf/
> 
> Hm.. one possible way is to create a platform device, and introduce a new
> platform device driver under drivers/perf/.

No, do not abuse platform drivers, you have a real device, use it.

