Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1519B58F8A
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2019 03:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfF1BM6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Jun 2019 21:12:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34400 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfF1BM6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 27 Jun 2019 21:12:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so2242781plt.1;
        Thu, 27 Jun 2019 18:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HTJPCjJAItenhyrt1rJvs3Mf5h+tB5nesrSZAXXGrQg=;
        b=TNZl1l9Nt+3OH+yuAWLQQ3PsDWKZMoEn4c/jRy8vgeI283SPFbNs0b1NX/w4cdDn3x
         jDwGk+ZWNZrP1YI5NPqyEkejOKqcipTi39/3lJOkxinpTPPhSRoweZ6QVPQWBlI9dbZZ
         OfMFoZnnsE/7E5WPJbAuu9qJHLA4H7YUQXCl7rOwggceqkaO/HKqi2cT8nXdLGOLtjfX
         fIA0l3uHihbQz3zrGYCRtpPE8Y1JksT1iGQFr2r8dkXd4qi6XO3+0h/z+XwUwF9bfbaX
         5eRrtyo5Vj6khsw5J6aGBIfu+1hMvf9O7xCrQXVEzbkmEwK/6KBNswfv//NSi/goaGS6
         wrOw==
X-Gm-Message-State: APjAAAVi9srphceUpJYLo89NYstsTYeiI5hQXLOSShxsU2Mo6Z1oQV3L
        MrKM5ASWcy0PNp7N7uB2YrGOsxdP1kc=
X-Google-Smtp-Source: APXvYqzF/LekOqHPf/FQ8SrJHjWxLUa8soZjO3WTgObBFHexIsDWDzdVBHHT922JpGd4/odXVgeRJw==
X-Received: by 2002:a17:902:ff11:: with SMTP id f17mr8318752plj.121.1561684377754;
        Thu, 27 Jun 2019 18:12:57 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id c26sm290047pfr.172.2019.06.27.18.12.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 18:12:57 -0700 (PDT)
Date:   Thu, 27 Jun 2019 18:12:56 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        yilun.xu@intel.com, gregkh@linuxfoundation.org, atull@kernel.org
Subject: Re: [PATCH v4 05/15] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
Message-ID: <20190628011256.GB5671@archbook>
References: <1561610695-5414-1-git-send-email-hao.wu@intel.com>
 <1561610695-5414-6-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561610695-5414-6-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Wu,

On Thu, Jun 27, 2019 at 12:44:45PM +0800, Wu Hao wrote:
> This patch adds virtualization support description for DFL based
> FPGA devices (based on PCIe SRIOV), and introductions to new
> interfaces added by new dfl private feature drivers.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> ---
>  Documentation/fpga/dfl.txt | 101 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.txt b/Documentation/fpga/dfl.txt
> index 6df4621..a22631f 100644
> --- a/Documentation/fpga/dfl.txt
> +++ b/Documentation/fpga/dfl.txt

This got re{named,formatted} in linux-next. I've tried to fix it before sending it
to Greg.

Thanks,
Moritz
