Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E610D423004
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Oct 2021 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJES3l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Oct 2021 14:29:41 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:35403 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhJES3l (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 Oct 2021 14:29:41 -0400
Received: by mail-pl1-f176.google.com with SMTP id w14so64687pll.2
        for <linux-fpga@vger.kernel.org>; Tue, 05 Oct 2021 11:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ARwdXd3LNow5xEonc1ZCmsKwSosFJiIOacWSeWGyfDc=;
        b=JqJ23DnqSsvNFQ7N5hG2VkD6MxcmGtuwn1gOnXnKwQzcosLJ5YrMR6w/I79wusc4dC
         TMeaFDqKLVmHJQtLftRlfW4HXXC4F/ySuU1KYTYKbQixn9dsqueUzAbJve3fS+g2RhtD
         fi4IdruFIvDFdgghVmmz0g/HTwL6f5NumvBoQXxlXZJDxOTEWtFnckpjO9tsW0TrBOsw
         YrOXquvfKP3RGeRT8PMqoq2CopDqCS/AJc36YqImk9Scdkb8w2bH6EpeGpU91pF+tMj8
         0xikOJvvS86kEQjQb92IgO0imMp/MzN4IFn6MI/vAKXLZsmSSv/2OqVCeydKwR03J4P6
         k7fg==
X-Gm-Message-State: AOAM532yg8mU4SGetox3TpoM787y0Xy5nT18AlcLE4WI6dqWtecfQ4C8
        Y0v4bK+9yje0ltvrKDCjh2g=
X-Google-Smtp-Source: ABdhPJxnNBmpSZESnTp765pMjWc+H79mwkARMY3YwKHqt+ZFk11/KnrD2zmEhTLHM8A3I3QW5Vd6TQ==
X-Received: by 2002:a17:902:9689:b0:138:d2ac:44f with SMTP id n9-20020a170902968900b00138d2ac044fmr6540670plp.85.1633458470270;
        Tue, 05 Oct 2021 11:27:50 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id q6sm4858415pgc.1.2021.10.05.11.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 11:27:49 -0700 (PDT)
Date:   Tue, 5 Oct 2021 11:27:48 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, hao.wu@intel.com, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: [GIT PULL] FPGA Manager changes for 5.16-rc1
Message-ID: <YVyZJAOnAphoe/Vh@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-maintainer-update

for you to fetch changes up to 57b44817a8d63e75394bc21849f585ded53de8bb:

  MAINTAINERS: Drop outdated FPGA Manager website (2021-10-02 09:07:09 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.16

The first patch adds Hao and Yilun as additional maintainers
for the FPGA Manager subsystem.

The second patch removes a now stale reference to a product specific
website that no longer reflects the FPGA Manager subsystem.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Moritz Fischer (2):
      MAINTAINERS: Add Hao and Yilun as maintainers
      MAINTAINERS: Drop outdated FPGA Manager website

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
