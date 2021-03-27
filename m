Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BC334B6D9
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Mar 2021 12:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhC0LjK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Mar 2021 07:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhC0LjJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 27 Mar 2021 07:39:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 657C061919;
        Sat, 27 Mar 2021 11:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616845149;
        bh=fo1Jxs5qYDKTc6Q8lTnQEbHRolH6RbJaAMNKdLej9wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5+mDclI4HIdGECsl2bOXsp57Bk1f/IWuDIzZhvQHVfjrZk835KU7X1rEPILGUdrp
         d0iXRjvnsKvs2sEykxdt1gWZU607m9tPGj1FfTt29+adiuoxIInO/8JbUWHx/dFIDA
         QjQhuDClhZrMPBdoYrDjjjBglqVWPwfP0CHhEnTU=
Date:   Sat, 27 Mar 2021 12:39:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager fix for 5.12
Message-ID: <YF8ZWja1+Y6PgRWA@kroah.com>
References: <YF4RlBeQ7cWLVboz@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF4RlBeQ7cWLVboz@archbook>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Mar 26, 2021 at 09:53:40AM -0700, Moritz Fischer wrote:
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> 
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-fixes-for-5.12

Pulled and pushed out, thanks.

greg k-h
