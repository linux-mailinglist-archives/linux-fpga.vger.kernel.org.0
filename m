Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4332F22A99A
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Jul 2020 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgGWHZb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Jul 2020 03:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgGWHZb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 23 Jul 2020 03:25:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656CE22CA0;
        Thu, 23 Jul 2020 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595489131;
        bh=VfAKlfxGzM1PSkqUl2tEI3DFP0XcgostHF2iqvPQChU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2AdaBwCURGdnGb9I4SstD6JQQF/fsyFMqCm6g3sUE+i/b0H7C8VAJ1ldjVm10N2xo
         5kj/ytjeI88MPG7Ay84ZufLSCTNbc9oCG1KBvueaJMSc2jRuwviuDuKauzIZ6TwBow
         HhonquNNY8IHnFdydCwksuz/xsWFGuTIU98DIAB8=
Date:   Thu, 23 Jul 2020 09:25:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     moritzf@google.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 5.9-rc1
Message-ID: <20200723072506.GA1178891@kroah.com>
References: <20200718021954.GA7272@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718021954.GA7272@epycbox.lan>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 17, 2020 at 07:19:54PM -0700, Moritz Fischer wrote:
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.9

Pulled and pushed out, thanks.

greg k-h
