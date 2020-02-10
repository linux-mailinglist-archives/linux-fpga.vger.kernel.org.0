Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A285158472
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Feb 2020 21:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgBJU4T (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Feb 2020 15:56:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgBJU4T (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 10 Feb 2020 15:56:19 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03CF320715;
        Mon, 10 Feb 2020 20:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581368179;
        bh=XCaEk4AdMscuCIsfWqjQ6jxocwU0q3rPW8RgAU4hDEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNHzMZzG1ARQhWBIv0yUDMr6OkJkpLDpCXFMHwXLYyqqrNa2YPR4cge58/XUUN9Rq
         hmx36I3lSVP3vzVZmr5SQPP/Q4BWZWRLmFM+F8HCm+YVjH6eVg1yqXfeJYCZ3x8JVc
         nVRNmd4VTLVOsSziz+5UTlJZMFBTBaVXrWFZyqnI=
Date:   Mon, 10 Feb 2020 12:56:18 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, will@kernel.org, mark.rutland@arm.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v7 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20200210205618.GA1347752@kroah.com>
References: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
 <1581306469-22629-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581306469-22629-3-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 10, 2020 at 11:47:49AM +0800, Wu Hao wrote:
> +What:		/sys/bus/event_source/devices/fmeX/format
> +Date:		February 2020
> +KernelVersion:  5.7
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. Attribute group to describe the magic bits
> +		that go into perf_event_attr.config for a particular pmu.
> +		(See ABI/testing/sysfs-bus-event_source-devices-format).
> +
> +		Each attribute under this group defines a bit range of the
> +		perf_event_attr.config. All supported attributes are listed
> +		below.
> +
> +		  event  = "config:0-11"  - event ID
> +		  evtype = "config:12-15" - event type
> +		  portid = "config:16-23" - event source
> +
> +		For example,
> +
> +		  fab_mmio_read = "event=0x06,evtype=0x02,portid=0xff"

Are perf sysfs files always this bad "multiple values per file"?  Or is
that unique to this driver?  If not unique, do you have specific
examples in the kernel that currently do this today?


> +static struct attribute *fme_perf_events_attrs_empty[] = {
> +	NULL,

Huh?

> +};
> +
> +static struct attribute_group fme_perf_events_group = {
> +	.name = "events",
> +	.attrs = fme_perf_events_attrs_empty,

You create an empty directory?  Why?  What goes in here?

very odd...

greg k-h
