Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E2110899B
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Nov 2019 09:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKYIBd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Nov 2019 03:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfKYIBd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Nov 2019 03:01:33 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA4420823;
        Mon, 25 Nov 2019 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574668892;
        bh=3dGZ/uLO5LTmwhX4KccMo0IPBL8NsgV979l3Ukwt6Lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJBslWiWLs5HahVlIuPQqKf+7RvPwNkBL4eOt44p8HC84BT0uI/ShBJkMsw8Lcz85
         qLGr1YqH0zq4tRxymtIPIRyvpyVm729X16asHZpkiG9blBoIQHwq5+mChHBBVxGznr
         GMM3Im09Gn3KCIe4rlQbq5c77B4MftcAjUm2THqM=
Date:   Mon, 25 Nov 2019 08:01:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, mark.rutland@arm.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v6 0/2] add performance reporting support to FPGA DFL
 drivers
Message-ID: <20191125080127.GC1809@willie-the-truck>
References: <1573622695-25607-1-git-send-email-hao.wu@intel.com>
 <20191125033412.GB890@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125033412.GB890@hao-dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Nov 25, 2019 at 11:34:12AM +0800, Wu Hao wrote:
> Hi Will and Mark,
> 
> Could you please help us on review this patchset? as this patchset mainly 
> introduced a new perf driver following the similar way as drivers/perf/*.

Why is it not under drivers/perf/, then?

> This patchset has been submitted for a long time but didn't receive any
> comment after v4. we appreciate any review comments! thanks in advance. :)

Hmm, not sure I saw the previous versions. Guessing I wasn't on cc?

Will
