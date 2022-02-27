Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CD4C5F50
	for <lists+linux-fpga@lfdr.de>; Sun, 27 Feb 2022 23:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiB0WHu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 27 Feb 2022 17:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiB0WHu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 27 Feb 2022 17:07:50 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D409D6C909
        for <linux-fpga@vger.kernel.org>; Sun, 27 Feb 2022 14:07:12 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id u2so1558189ple.10
        for <linux-fpga@vger.kernel.org>; Sun, 27 Feb 2022 14:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/j7yqEfI+84d2M1zenejrky8onCjWeYBJfQAyWPiY+4=;
        b=5TJETdNoIzGEZTMNuohA7+fyj9VHPvZ4WiNANg27E/MCLhDEKDNgWw0LsN+lFXPCJK
         PTWNx8yLXNKAAYzAvx5n7AeD44vrTIZcwdg+2j+uiSz10AOx8sSIsjywjwLzjYLsTJ4s
         8FoZyWOvqsrG4G7foNd7RpSnjuswz1vuLjq55GbufMZgnaNv4FKCCcZEDQWdMcfFrluL
         WKjZozzJH/dqNocSwoqUBszIrumnb4jjmi+2xjo8zhTIKMR1iX6VJUlzlclFQSMlnoqK
         wncothwEV+5CJ/FLmveHL6bkjL44VyLJf6bPk24Uj4N3Ui+f+MO5OguFlZo+7AO4w+I6
         vjYA==
X-Gm-Message-State: AOAM531qA0Cc2FgI4Vsr1u+BFk8RbLYW1Z8PYWlWApgzlHfffK47TcY7
        FMwrfA07oY7zTi8T2U3DuGY=
X-Google-Smtp-Source: ABdhPJyjIc7YlQ97Oa4sNAqVAUQzt07rOuUq0UBEQtB4lB/W42hEfowC6Gj1eRuHPtTFfVtEk7nbfA==
X-Received: by 2002:a17:90a:588c:b0:1b9:d80e:e397 with SMTP id j12-20020a17090a588c00b001b9d80ee397mr13642694pji.237.1645999632025;
        Sun, 27 Feb 2022 14:07:12 -0800 (PST)
Received: from localhost ([2601:647:5b00:ece1:6248:e226:d2e0:1f33])
        by smtp.gmail.com with ESMTPSA id g5-20020a655805000000b003643e405b56sm8442104pgr.24.2022.02.27.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 14:07:11 -0800 (PST)
Date:   Sun, 27 Feb 2022 14:07:10 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org
Subject: [GIT PULL] FPGA Manager change for 5.18-rc1
Message-ID: <Yhv2DnIMuYrleRJK@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 21f0a239ecab4b6765269af78904512358beb802:

  fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API (2022-01-25 11:25:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.18-rc1

for you to fetch changes up to 21f0a239ecab4b6765269af78904512358beb802:

  fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API (2022-01-25 11:25:50 -0800)

----------------------------------------------------------------
FPGA Manager changes for 5.18-rc1

Christophe's patch is part of a larger effort of removing the use of the
deprecated pci-dma-compat API.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of our for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
