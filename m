Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCA820E0C
	for <lists+linux-fpga@lfdr.de>; Thu, 16 May 2019 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfEPRg4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 May 2019 13:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfEPRgz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 May 2019 13:36:55 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C16920862;
        Thu, 16 May 2019 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558028215;
        bh=J0o9e5r85qw6Ct6cW0lnogaTj29MCoNBY5Ih5VQs1lI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u10IDwUVP8rJJm66oGFoBRhxh9MWzvsgFmPE4/c0gr8b/WN9Uk6dO7TkxFRWQOE5P
         bZlZgF/EMahvyY2MatNW814Yco7+Co3vz8woPup/+G6C95TtkLx8hPTegEi5jqJYPr
         0lmTAFIJskrtU4Iypofsblx0fz0BS8CcS5YorCF8=
Received: by mail-ed1-f48.google.com with SMTP id w33so6351448edb.10;
        Thu, 16 May 2019 10:36:55 -0700 (PDT)
X-Gm-Message-State: APjAAAUS5bKxCiP/10SmiNkKrxLsiVaufnYCc5NUVzdsz+02Fl6bBHIj
        fw0hcj8AK1BE+6gVT+SwHw3G+AF002Ci2iM5doE=
X-Google-Smtp-Source: APXvYqyan6695N5GdU2kofq+FcBtbqzSkRu8JRB/p3E9v6O6Oo0ldkOStBLBH6IHZJv+VXfnhvljdQA1j1owXABNx9c=
X-Received: by 2002:a50:9266:: with SMTP id j35mr53083454eda.60.1558028213752;
 Thu, 16 May 2019 10:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com> <1556528151-17221-6-git-send-email-hao.wu@intel.com>
In-Reply-To: <1556528151-17221-6-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 16 May 2019 12:36:17 -0500
X-Gmail-Original-Message-ID: <CANk1AXQSL8k=FOLv4_rLfRHBqOi=CW=yP3O8ch4VEa25cj9+Cw@mail.gmail.com>
Message-ID: <CANk1AXQSL8k=FOLv4_rLfRHBqOi=CW=yP3O8ch4VEa25cj9+Cw@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Apr 29, 2019 at 4:12 AM Wu Hao <hao.wu@intel.com> wrote:
>
> This patch adds virtualization support description for DFL based
> FPGA devices (based on PCIe SRIOV), and introductions to new
> interfaces added by new dfl private feature drivers.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan
