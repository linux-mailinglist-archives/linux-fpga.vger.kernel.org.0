Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB282F18BF
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbhAKOxd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 09:53:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730159AbhAKOxd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 09:53:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A66E2255F;
        Mon, 11 Jan 2021 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610376772;
        bh=FECXBa4dNSkuOyEw3XtlOEGphuAeMSFi7EmDWf++C1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5Y2MUioJBe9oqoLyx1Iyg+d3y9PrU4v3PWoWEFfvGnbcQR7eGs+/hMiqvG2JClpN
         68asrzP0V1u+sdfgfCwK7kuyFJZdOhmuyFVIWLZUOWpfy3aqfxpCy6tQis3qIN4hZp
         PYqB+y6RLU3zHwTFXscYMOti1J16ZeWHnmdEpZG0=
Date:   Mon, 11 Jan 2021 15:54:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel@vger.kernel.org, moritzf@google.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
Message-ID: <X/xmi/jJmDHnV5/N@kroah.com>
References: <20210107043714.991646-1-mdf@kernel.org>
 <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
 <e1d30642-ce85-b9b7-e8b2-5ad4fe6338e5@redhat.com>
 <X/sz6lDq8WFzrRUJ@archbook>
 <95af46d6-d123-f610-2f21-6d6de6f248e9@redhat.com>
 <X/v2xs5Rnfw9F18E@kroah.com>
 <9bc01a73-726f-a979-1246-6ea048961670@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bc01a73-726f-a979-1246-6ea048961670@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 11, 2021 at 06:40:24AM -0800, Tom Rix wrote:
> 
> On 1/10/21 10:57 PM, Greg KH wrote:
> > On Sun, Jan 10, 2021 at 11:43:54AM -0800, Tom Rix wrote:
> >> On 1/10/21 9:05 AM, Moritz Fischer wrote:
> >>> Tom,
> >>>
> >>> On Sun, Jan 10, 2021 at 07:46:29AM -0800, Tom Rix wrote:
> >>>> On 1/7/21 8:09 AM, Tom Rix wrote:
> >>>>> On 1/6/21 8:37 PM, Moritz Fischer wrote:
> >>>>>> This is a resend of the previous (unfortunately late) patchset of
> >>>>>> changes for FPGA DFL.
> >>>>> Is there something I can do to help ?
> >>>>>
> >>>>> I am paid to look after linux-fpga, so i have plenty of time.
> >>>>>
> >>>>> Some ideas of what i am doing now privately i can do publicly.
> >>>>>
> >>>>> 1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.
> >>> Is it not? It currently points to v5.11-rc1. If I start applying patches
> >>> that require the changes that went into Greg's branch I can merge.
> >> I mean the window between when we have staged patches and when they go into Greg's branch.
> >>
> >> We don't have any now, maybe those two trival ones.
> >>
> >> Since Greg's branch moves much faster than ours, our staging branch needs to be rebased regularly until its merge.
> > Ick, no!  NEVER rebase a public branch.  Why does it matter the speed of
> > my branch vs. anyone elses?  Git handles merges very well.
> >
> > Just like Linus's branches move much faster than mine, and I don't
> > rebase my branches, you shouldn't rebase yours.
> >
> > Becides, I'm only taking _PATCHES_ for fpga changes at the moment, no
> > git pulls, so why does it matter at all for any of this?
> >
> > What is the problem you are trying to solve here?
> 
> This 5.12 fpga patchset not making it into 5.11.

Ok, but isn't it the responsibility of the submitter to make sure they
apply properly when sending them out?

> At some point before the 5.11 window, I tried it on next and it failed to merge.
> 
> This points to needing some c/i so it does not happen again.

"again"?  Merges and the like are a totally normal thing and happen all
the time, I still fail to understand what you are trying to "solve" for
here...

thanks,

greg k-h
