Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1F345A38
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Mar 2021 10:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCWJAh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Mar 2021 05:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCWJA0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 23 Mar 2021 05:00:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97B7D60C40;
        Tue, 23 Mar 2021 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616490023;
        bh=jqqOFYKfkkutvKIuc3p52smv+otkqnc4YLo5crlhoOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikDDLXVlc4rJ+RMLQ7AF1e9kt/0mh+Dc+S+WL5Awhnvx1hi+oq6v8+tufDlilyHwQ
         4IkDxled+0wQw7QQxwZEQM44hq14q9rVuwjdEw78NIzvZyqynOLRlV7vWziN2o0670
         0UJwPVY8Is7ytbPsyNdqKtlunb2fD5ET8cIdNc/Q=
Date:   Tue, 23 Mar 2021 10:00:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] First set of FPGA Manager changes for 5.13-rc1
Message-ID: <YFmuIbD+3+mfqMSW@kroah.com>
References: <YFT31lF36GipRKte@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFT31lF36GipRKte@archbook>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Mar 19, 2021 at 12:13:26PM -0700, Moritz Fischer wrote:
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> 
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.13

Pulled and pushed out, thanks.

greg k-h
