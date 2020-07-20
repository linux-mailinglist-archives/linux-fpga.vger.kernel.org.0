Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C409922598E
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jul 2020 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgGTIBB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jul 2020 04:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTIBB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 20 Jul 2020 04:01:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D158020702;
        Mon, 20 Jul 2020 08:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595232061;
        bh=LmnmOr9bZrI+OSg3ACxiPbwpTzNjUKxhZGxEN8QjcsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwAfBSs1gNL2zsDmH/FqhFc3ks1csBkdK3UgL5V78ktEM+d3MU8TcICG0n28GuSIw
         2SdNH/b58K1V3I82EKsU7odgguHkGMiAWzDGULWLRnLsucFYbJrbfuaKHIocghPgJw
         Nsi/XXzAMY6Y7po6/vyZDIpCTVkyWQsGdEq4SeTs=
Date:   Mon, 20 Jul 2020 10:01:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager (late) fixes for 5.8
Message-ID: <20200720080111.GA553171@kroah.com>
References: <20200717234408.GA4556@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717234408.GA4556@epycbox.lan>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 17, 2020 at 04:44:08PM -0700, Moritz Fischer wrote:
> The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:
> 
>   Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git fpga-late-fixes-for-5.8
> 
> for you to fetch changes up to 8614afd689df59d9ce019439389be20bd788a897:
> 
>   fpga: dfl: fix bug in port reset handshake (2020-07-13 22:11:17 -0700)
> 
> ----------------------------------------------------------------
> FPGA manager fixes for 5.8
> 
> Here are two (late) dfl fixes for the the 5.8 release.
> 
> Matthew's fix addresses an issue in the reset of a port.
> 
> Xu'x fix addresses a linter warning.

That's not a "real" issue, and should have waited until 5.9-rc1 as there
is no bug being fixed there at all.  I'll take it for now, but be more
careful in the future.

thanks,

greg k-h
