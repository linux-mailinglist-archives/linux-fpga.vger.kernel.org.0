Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BAF1B5D5E
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Apr 2020 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDWOMh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Apr 2020 10:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbgDWOMh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 23 Apr 2020 10:12:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D592E20857;
        Thu, 23 Apr 2020 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587651157;
        bh=t+AWIuxSGU777IjVUf8NCTAQTb9C3C7ZjUtaL9pjEBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJZLK7UR9NQEWa/4Jp660+92N+Pq0zZGOs0/UyPJf/HbddOriPofI7XLs7rW5/4tX
         2pb+NtVlqIwhP+aYXtmdpvLHaFwmqirq6TBTmNfprLpkvH04ijsQOBAWt/qkzFh2Fp
         afpJgG/SzA+yqkNs1MceL7W6/fHllLTB9fCKWl9g=
Date:   Thu, 23 Apr 2020 16:12:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     moritzf@google.com, linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager (late) fixes for 5.7
Message-ID: <20200423141227.GA4154036@kroah.com>
References: <20200331035459.GA3472@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331035459.GA3472@epycbox.lan>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Mar 30, 2020 at 08:54:59PM -0700, Moritz Fischer wrote:
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ fpga-fixes-for-5.7

Pulled and pushed out,t hanks,.

greg k-h
