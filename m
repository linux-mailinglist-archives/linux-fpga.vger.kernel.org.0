Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E299F144E2A
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2020 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAVJDi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Jan 2020 04:03:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgAVJDi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 22 Jan 2020 04:03:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0173C2253D;
        Wed, 22 Jan 2020 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579683817;
        bh=xOCjk7jFdQIz3lKsJVThubZKJYbF/KvLm1vKloTQd4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xE5cqIrdhJ6wlJGc7f9gANNEvvC1W9zH84mKDJUSBxhi1KZ5uwa1/BYKe1944+QKk
         iqqkOs/MPVvLoxLOKatwlPyodsjfWppwoSzT1yA3LnbT1hD5x41ctfhgCzL1b/+UjH
         NPaIl9W9I7A0ec7lWN/CFNmZV84rjdDs1YbSKaoI=
Date:   Wed, 22 Jan 2020 10:03:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA changes for 5.6
Message-ID: <20200122090328.GA2577253@kroah.com>
References: <20200121012248.GA3890@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121012248.GA3890@epycbox.lan>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 20, 2020 at 05:22:48PM -0800, Moritz Fischer wrote:
> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> 
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-for-5.6

Pulled and pushed out, thanks.

greg k-h
