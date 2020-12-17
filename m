Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0230B2DD5B7
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Dec 2020 18:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgLQRKQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Dec 2020 12:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgLQRKQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Dec 2020 12:10:16 -0500
Date:   Thu, 17 Dec 2020 18:10:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608224975;
        bh=0jEK+C+w87Pch7egdMjoBVbIkqvM5UoNUVPWiKQ7t98=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=eb7ltVHErC3Oc2LPPKoo+8yCj7hc5w3koLwubMeWdTCYZ2bt5QtKe48QSiMkXWT5S
         BkFe1fT3B6LtFF4rpz3pAlHhD1i+/nBE49h3oY71Zb+Z6iWRU9Fn5l1+baMu190DNs
         UznSQy2zMV6FPS0PH/Bt0V9ymya9XfpaaEkSkmEY=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 0/3] UIO support for dfl devices
Message-ID: <X9uRHzCyS1FNw4e6@kroah.com>
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
 <85d48e41-0185-0938-b0ed-93d0f825e761@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d48e41-0185-0938-b0ed-93d0f825e761@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Dec 17, 2020 at 05:35:51AM -0800, Tom Rix wrote:
> 
> On 12/16/20 9:44 PM, Xu Yilun wrote:
> > This patchset supports some dfl device drivers written in userspace.
> >
> > In the patchset v1, the "driver_override" interface should be used to bind
> > the DFL UIO driver to DFL devices. But there is concern that the
> > "driver_override" interface is not OK itself. So in v2, we use a new
> > matching algorithem. The "driver_override" interface is abandoned, the DFL
> > UIO driver matches any DFL device which could not be handled by other DFL
> > drivers. So the DFL UIO driver could be used for new DFL devices which are
> > not supported by kernel, also it will not impact the devices which are
> > already got supported.
> 
> This set looks good to me.
> 
> Moritz,
> 
> Is it possible to get this into 5.11 ?

How would that be possible?

New features have to be in linux-next successfully, _BEFORE_ the merge
window opens.  Please read Documentation/process/ for how we do all of
this...

thanks,

greg k-h
