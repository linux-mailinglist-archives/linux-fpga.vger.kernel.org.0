Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468113A7802
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Jun 2021 09:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFOHcp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Jun 2021 03:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbhFOHco (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Jun 2021 03:32:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0F0B6140B;
        Tue, 15 Jun 2021 07:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623742239;
        bh=YdZv7//wDw5tPEHf2siEyshMHjmqwzHoVCNdEFguZX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAHvJJB4n+5+c1y+jCrQSa4rbXTRbdCV3FvXv3GQd9Z2F1iNlNtOtR9Oz62ADNVHl
         ZcguOrrSvGXwdcRyEuFjjFh2VmKv/UkC2wQritPavpSxcwwZVp3kVAF6ZLuibq6T06
         M6xr48TwfmwsZ8n2CNz6caLc2DCu6ZFufViRPnEQ=
Date:   Tue, 15 Jun 2021 09:30:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org
Subject: Re: [PATCH 0/8] FPGA Manager devres cleanup
Message-ID: <YMhXEixR9wLqn+Mp@kroah.com>
References: <20210614170909.232415-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614170909.232415-1-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 14, 2021 at 10:09:01AM -0700, Moritz Fischer wrote:
> Hi Greg,
> 
> please consider this series for inclusion into 5.14-rc1.
> 
> It attempts to clean up the issues pointed out by you earlier
> in https://lore.kernel.org/linux-fpga/YKKuBSLp5Fe0Zh0v@kroah.com
> 
> If you prefer I can provide a signed tag instead.

No need, I took the first 5 patches here, the last 3 need more work.

thanks,

greg k-h
