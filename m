Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF87326D7A
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Feb 2021 16:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhB0PIN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Feb 2021 10:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhB0PIM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 27 Feb 2021 10:08:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6B5164E7A;
        Sat, 27 Feb 2021 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614438452;
        bh=NtBYbqsqe2ZK9BWLJir8CO6pNkINMOV2L6wftv5KqAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k01592FcVDYoGQUhSHSfzHjlpwmJLUk5nPyNsqqnMud8lDtT2r7mcYgdHzWWoyV2m
         eG6VvVzUQUBl6xndffdGcMBaneVFeiVswNsE3quRn5qpIPueiCGhM4yvbKZ+guweLJ
         dL93pKlc9AZ7F1ubQoXsWxm+x/t00cljWH420Hhw=
Date:   Sat, 27 Feb 2021 16:07:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v11 0/2] UIO support for dfl devices
Message-ID: <YDpgMWSzw1nD64Cz@kroah.com>
References: <1612403971-13291-1-git-send-email-yilun.xu@intel.com>
 <9b5f6e54-7122-8cfb-39f8-a84599e081f1@redhat.com>
 <20210226012237.GA27194@yilunxu-OptiPlex-7050>
 <YDiX+Fl0AiQrdZJL@kroah.com>
 <20210227145733.GA2224@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210227145733.GA2224@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Feb 27, 2021 at 10:57:33PM +0800, Xu Yilun wrote:
> Hi Greg:
> 
> On Fri, Feb 26, 2021 at 07:40:56AM +0100, Greg KH wrote:
> > On Fri, Feb 26, 2021 at 09:22:37AM +0800, Xu Yilun wrote:
> > > On Mon, Feb 22, 2021 at 10:56:45AM -0800, Tom Rix wrote:
> > > > Yilun,
> > > > 
> > > > Is there anything outstanding or remaining to be done ?
> > > 
> > > Sorry for late reply. No, this is my lastest version now.
> > > 
> > > 
> > > Hi Greg:
> > > 
> > > Do you have some comments on this patchset?
> > 
> > It's the middle of the merge window, I can't accept anything right
> > now...
> > 
> > But this doesn't even look like it is in my "to review" queue anymore,
> > which means that there must have been a lot of discussion on it and
> > others asking for changes, so why not work on that right now while you
> > can and resubmit it when you have done that?
> > 
> > No need to ever wait on me for fixing things up.
> 
> I checked the mails again and confirmed all the comments from Moritz,
> Tom and Hao are fixed. So could you help review it so it could be
> accepted in next cycle?

Please resend it, as I said above, it is no longer in my queue.

greg k-h
