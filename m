Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330623A5F18
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 11:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhFNJaw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 05:30:52 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54950 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhFNJau (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Jun 2021 05:30:50 -0400
Received: from [77.244.183.192] (port=64040 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lsiti-00079a-67; Mon, 14 Jun 2021 11:28:46 +0200
Subject: Re: [PATCH v3 1/4] fpga: dfl: reorganize to subdir layout
To:     trix@redhat.com, mdf@kernel.org, hao.wu@intel.com,
        michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        krzysztof.kozlowski@canonical.com, dinguyen@kernel.org,
        nava.manne@xilinx.com, yilun.xu@intel.com, davidgow@google.com,
        fpacheco@redhat.com, richard.gong@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210611162129.3203483-1-trix@redhat.com>
 <20210611162129.3203483-3-trix@redhat.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <3e83dee8-4746-b22b-c032-1d73364f9cb7@lucaceresoli.net>
Date:   Mon, 14 Jun 2021 11:28:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611162129.3203483-3-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On 11/06/21 18:21, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Follow drivers/net/ethernet/ which has control configs
> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
> Since fpgas do not have many vendors, drop the 'VENDOR' and use
> FPGA_BLA.
> 
> There are several new subdirs
> altera/
> dfl/
> lattice/
> xilinx/
> 
> Each subdir has a Kconfig that has a new/reused
> 
> if FPGA_BLA
>   ... existing configs ...
> endif FPGA_BLA
> 
> Which is sourced into the main fpga/Kconfig
> 
> Each subdir has a Makefile whose transversal is controlled in the
> fpga/Makefile by
> 
> obj-$(CONFIG_FPGA_BLA) += bla/
> 
> This is the dfl/ subdir part.
> 
> Create a dfl/ subdir
> Move dfl-* files to it.
> Add a Kconfig and Makefile
> 
> Because FPGA_DFL is now used in dfl/Kconfig in a if/endif
> block, all the other configs in dfl/Kconfig implicitly depend
> on FPGA_DFL.  So the explicit dependence can be removed.  Also
> since FPGA_DFL depends on HAS_IOMEM, it can be removed from the
> other configs.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  MAINTAINERS                                 |  2 +-
>  drivers/fpga/Kconfig                        | 80 +-------------------
>  drivers/fpga/Makefile                       | 18 +----
>  drivers/fpga/dfl/Kconfig                    | 83 +++++++++++++++++++++
>  drivers/fpga/dfl/Makefile                   | 16 ++++
>  drivers/fpga/{ => dfl}/dfl-afu-dma-region.c |  0
>  drivers/fpga/{ => dfl}/dfl-afu-error.c      |  0
>  drivers/fpga/{ => dfl}/dfl-afu-main.c       |  0
>  drivers/fpga/{ => dfl}/dfl-afu-region.c     |  0
>  drivers/fpga/{ => dfl}/dfl-afu.h            |  0
>  drivers/fpga/{ => dfl}/dfl-fme-br.c         |  0
>  drivers/fpga/{ => dfl}/dfl-fme-error.c      |  0
>  drivers/fpga/{ => dfl}/dfl-fme-main.c       |  0
>  drivers/fpga/{ => dfl}/dfl-fme-mgr.c        |  0
>  drivers/fpga/{ => dfl}/dfl-fme-perf.c       |  0
>  drivers/fpga/{ => dfl}/dfl-fme-pr.c         |  0
>  drivers/fpga/{ => dfl}/dfl-fme-pr.h         |  0
>  drivers/fpga/{ => dfl}/dfl-fme-region.c     |  0
>  drivers/fpga/{ => dfl}/dfl-fme.h            |  0
>  drivers/fpga/{ => dfl}/dfl-n3000-nios.c     |  0
>  drivers/fpga/{ => dfl}/dfl-pci.c            |  0
>  drivers/fpga/{ => dfl}/dfl.c                |  0
>  drivers/fpga/{ => dfl}/dfl.h                |  0
>  23 files changed, 102 insertions(+), 97 deletions(-)
>  create mode 100644 drivers/fpga/dfl/Kconfig
>  create mode 100644 drivers/fpga/dfl/Makefile
>  rename drivers/fpga/{ => dfl}/dfl-afu-dma-region.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-afu-error.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-afu-main.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-afu-region.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-afu.h (100%)
>  rename drivers/fpga/{ => dfl}/dfl-fme-br.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-fme-error.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-fme-main.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-fme-mgr.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-fme-perf.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-fme-pr.c (100%)

You should update Documentation/fpga/dfl.rst too as it mentions
"drivers/fpga/dfl-fme-pr.c". This update was in your initial patch 5 so
it's lost now, but it really should be in this patch.

>  rename drivers/fpga/{ => dfl}/dfl-fme-pr.h (100%)
>  rename drivers/fpga/{ => dfl}/dfl-fme-region.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-fme.h (100%)
>  rename drivers/fpga/{ => dfl}/dfl-n3000-nios.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl-pci.c (100%)
>  rename drivers/fpga/{ => dfl}/dfl.c (100%)

Same as above.

-- 
Luca
