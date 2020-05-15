Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172A41D501F
	for <lists+linux-fpga@lfdr.de>; Fri, 15 May 2020 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOOMN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 15 May 2020 10:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOOMN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 15 May 2020 10:12:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00BDC2076A;
        Fri, 15 May 2020 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589551933;
        bh=7mj3XsfQLTCFnW58XM93bILKz/8CIRaKV3Pnp3UacVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNhwwesYruMsCcU7VuIX3HN/LJk9Wi15Q4Ln/UqQES9Zl3qIUJZVFvuUD0AVrICJT
         96ZGQ+7YwYAjWY/0LJ/DDu7hj7iSWTTvqT4qB4rspy5/WWhrvRotwlL1x9If7O/Ivc
         2RvKn63wWQS2eIZs+W2wNNPqZ3RZf8lFrdWVz0M0=
Date:   Fri, 15 May 2020 16:11:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     moritzf@google.com, linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 5.8
Message-ID: <20200515141153.GC2184507@kroah.com>
References: <20200509181355.GA3828@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509181355.GA3828@epycbox.lan>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, May 09, 2020 at 11:13:55AM -0700, Moritz Fischer wrote:
> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
> 
>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.8

Pulled and pushed out.

greg k-h
